import UIKit
import FirebaseDatabase

class MPhotos
{
    typealias AlbumId = String
    typealias PhotoId = String
    
    enum Status:Int
    {
        case waiting
        case synced
        case deleting
    }
    
    static let sharedInstance:MPhotos = MPhotos()
    static let kThumbnailSize:CGFloat = 100
    let defaultAlbum:MPhotosItemDefault
    private var photoDeletables:[MPhotosItemPhoto]
    private(set) var albumItems:[AlbumId:MPhotosItemUser]
    private(set) var albumReferences:[MPhotosItemReference]
    private(set) var photos:[PhotoId:MPhotosItemPhoto]
    private var loading:Bool
    private let kZero:Int = 0
    
    private init()
    {
        loading = false
        defaultAlbum = MPhotosItemDefault()
        albumItems = [:]
        photoDeletables = []
        albumReferences = []
        photos = [:]
    }
    
    //MARK: private
    
    private func asyncLoadAlbums()
    {
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId
            
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyAlbums:String = FDatabaseModelUser.Property.albums.rawValue
        let path:String = "\(parentUser)/\(userId)/\(propertyAlbums)"
        defaultAlbum.clearReferences()
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelAlbumList.self)
        { (albumList:FDatabaseModelAlbumList?) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                guard
                    
                    let albumsMap:[AlbumId:FDatabaseModelAlbum] = albumList?.items
                    
                else
                {
                    self.asyncLoadPhotos()
                    
                    return
                }
                
                self.compareAlbums(albumsMap:albumsMap)
            }
        }
    }
    
    private func compareAlbums(albumsMap:[AlbumId:FDatabaseModelAlbum])
    {
        var items:[AlbumId:MPhotosItemUser] = [:]
        var references:[MPhotosItemReference] = []
        let albumsIds:[AlbumId] = Array(albumsMap.keys)
        
        for albumId:AlbumId in albumsIds
        {
            guard
                
                let firebaseAlbum:FDatabaseModelAlbum = albumsMap[albumId]
                
            else
            {
                continue
            }
            
            let albumName:String = firebaseAlbum.name
            let newItem:MPhotosItemUser = MPhotosItemUser(
                albumId:albumId,
                firebaseAlbum:firebaseAlbum)
            let albumReference:MPhotosItemReference = MPhotosItemReference(
                albumId:albumId,
                name:albumName)
            
            items[albumId] = newItem
            references.append(albumReference)
        }
        
        references.sort
        { (referenceA:MPhotosItemReference, referenceB:MPhotosItemReference) -> Bool in
            
            let before:Bool
            let nameA:String = referenceA.name
            let nameB:String = referenceB.name
            let comparison:ComparisonResult = nameA.compare(nameB)
            
            switch comparison
            {
                case ComparisonResult.orderedDescending:
                
                    before = false
                    
                    break
                
                default:
                
                    before = true
                    
                    break
            }
            
            return before
        }
        
        self.albumItems = items
        self.albumReferences = references
        
        asyncLoadPhotos()
    }
    
    private func asyncLoadPhotos()
    {
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId
            
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let path:String = "\(parentUser)/\(userId)/\(propertyPhotos)"
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelPhotoList.self)
        { (photoList:FDatabaseModelPhotoList?) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                guard
                    
                    let photosMap:[PhotoId:FDatabaseModelPhoto] = photoList?.items
                    
                else
                {
                    self.photoDeletables = []
                    self.albumReferences = []
                    self.photosLoaded()
                    
                    return
                }
                
                self.comparePhotos(photosMap:photosMap)
            }
        }
    }
    
    private func comparePhotos(photosMap:[PhotoId:FDatabaseModelPhoto])
    {
        var items:[PhotoId:MPhotosItemPhoto] = [:]
        var deletables:[MPhotosItemPhoto] = []
        let photosIds:[PhotoId] = Array(photosMap.keys)
        
        for photoId:PhotoId in photosIds
        {
            guard
                
                let firebasePhoto:FDatabaseModelPhoto = photosMap[photoId]
                
            else
            {
                continue
            }
            
            let photoStatus:MPhotos.Status = firebasePhoto.status
            let photoCreated:TimeInterval = firebasePhoto.created
            let kiloBytes:Int = firebasePhoto.size
            let albumId:AlbumId = firebasePhoto.albumId
            let album:MPhotosItem?
            
            if albumId.isEmpty
            {
                album = defaultAlbum
            }
            else
            {
                album = albumItems[albumId]
            }
            
            if photoStatus == Status.synced
            {
                if let loadedItem:MPhotosItemPhoto = self.photos[photoId]
                {
                    items[photoId] = loadedItem
                }
                else
                {
                    let newItem:MPhotosItemPhoto = MPhotosItemPhoto(
                        photoId:photoId,
                        firebasePicture:firebasePhoto)
                    items[photoId] = newItem
                }
                
                let photoReference:MPhotosItemPhotoReference = MPhotosItemPhotoReference(
                    photoId:photoId,
                    created:photoCreated)
                
                album?.addReference(
                    reference:photoReference,
                    kiloBytes:kiloBytes)
            }
            else
            {
                let deleteItem:MPhotosItemPhoto = MPhotosItemPhoto(
                    photoId:photoId,
                    firebasePicture:firebasePhoto)
                deletables.append(deleteItem)
            }
        }
        
        self.photos = items
        self.photoDeletables = deletables
        
        sortAlbums()
    }
    
    private func sortAlbums()
    {
        defaultAlbum.sortPhotos()
        
        for albumReference:MPhotosItemReference in albumReferences
        {
            guard
            
                let album:MPhotosItem = albumItems[albumReference.albumId]
            
            else
            {
                continue
            }
            
            album.sortPhotos()
        }
        
        photosLoaded()
    }
    
    private func photosLoaded()
    {
        loading = false
        NotificationCenter.default.post(
            name:Notification.photosLoaded,
            object:nil)
        
        deletePictures()
    }
    
    private func asyncCleanResources()
    {
        let allPhotos:[PhotoId] = Array(photos.keys)
        
        for photoId:PhotoId in allPhotos
        {
            let photo:MPhotosItemPhoto? = photos[photoId]
            photo?.resources.cleanResources()
        }
    }
    
    private func deletePictures()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncDeletePictures()
        }
    }
    
    private func asyncDeletePictures()
    {
        if !loading
        {
            guard
                
                let photo:MPhotosItemPhoto = photoDeletables.popLast()
                
            else
            {
                return
            }
            
            removeFromStorage(photo:photo)
        }
    }
    
    private func removeFromStorage(photo:MPhotosItemPhoto)
    {
        guard
        
            let userId:MSession.UserId = MSession.sharedInstance.user.userId
        
        else
        {
            return
        }
        
        let photoId:PhotoId = photo.photoId
        let parentUser:String = FStorage.Parent.user.rawValue
        let photoPath:String = "\(parentUser)/\(userId)/\(photoId)"
        
        FMain.sharedInstance.storage.deleteData(
            path:photoPath)
        { (error:Error?) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                if error == nil
                {
                    FMain.sharedInstance.analytics?.cleanPhotoDeletable()
                }
                else
                {
                    FMain.sharedInstance.analytics?.cleanPhotoDeletableNoData()
                }
                
                self.removeFromDatabase(photo:photo)
            }
        }
    }
    
    private func removeFromDatabase(photo:MPhotosItemPhoto)
    {
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId
            
        else
        {
            return
        }
        
        let photoId:PhotoId = photo.photoId
        let photoSize:Int = photo.size
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        let photoPath:String = "\(parentUser)/\(userId)/\(propertyPhotos)/\(photoId)"
        let diskUsedPath:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
        
        FMain.sharedInstance.database.transaction(
            path:diskUsedPath)
        { (mutableData:FIRMutableData) -> (FIRTransactionResult) in
            
            if let currentDiskUsed:Int = mutableData.value as? Int
            {
                var newDataLength:Int = currentDiskUsed - photoSize
                
                if newDataLength < self.kZero
                {
                    newDataLength = self.kZero
                }
                
                mutableData.value = newDataLength
            }
            else
            {
                mutableData.value = self.kZero
            }
            
            let transactionResult:FIRTransactionResult = FIRTransactionResult.success(
                withValue:mutableData)
            
            return transactionResult
        }
        
        FMain.sharedInstance.database.removeChild(path:photoPath)
        
        deletePictures()
    }
    
    //MARK: public
    
    func loadPhotos()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            if !self.loading
            {
                self.loading = true
                self.asyncLoadAlbums()
            }
        }
    }
    
    func cleanResources()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncCleanResources()
        }
    }
}
