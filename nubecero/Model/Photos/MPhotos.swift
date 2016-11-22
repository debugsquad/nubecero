import Foundation

class MPhotos
{
    typealias AlbumId = String
    typealias PhotoId = String
    
    enum Status:Int
    {
        case waiting
        case synced
    }
    
    static let sharedInstance:MPhotos = MPhotos()
    let defaultAlbum:MPhotosItemDefault
    var albumItems:[AlbumId:MPhotosItemUser]
    var photoDeletables:[MPhotosItemPhoto]
    var albumReferences:[MPhotosItemReference]
    private var photos:[PhotoId:MPhotosItemPhoto]
    private var loading:Bool
    
    private init()
    {
        loading = false
        defaultAlbum = MPhotosItemDefault()
        albumItems = [:]
        photoDeletables = []
        albumReferences = []
        photos = [:]
        
        loadPhotos()
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
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelAlbumList.self)
        { (albumList) in
            
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
        defaultAlbum.clearReferences()
        
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
        { (referenceA, referenceB) -> Bool in
            
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
        { (photoList) in
            
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
        
        photosLoaded()
    }
    
    private func photosLoaded()
    {
        NotificationCenter.default.post(
            name:Notification.photosLoaded,
            object:nil)
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
    
    //MARK: public
    
    func loadPhotos()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            if !self.loading
            {
                self.loading = true
                self.asyncLoadPhotos()
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
