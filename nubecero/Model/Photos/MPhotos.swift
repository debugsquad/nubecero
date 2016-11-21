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
        defaultAlbum.references = []
        
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
            let albumId:AlbumId = firebasePhoto.album
            
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
                
                references.append(photoReference)
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
        for reference:MPicturesItemReference in references
        {
            let pictureId:PictureId = reference.pictureId
            let item:MPicturesItem? = items[pictureId]
            item?.cleanResources()
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
    
    func pictureAtIndex(index:Int) -> MPicturesItem
    {
        let reference:MPicturesItemReference = references[index]
        let picture:MPicturesItem = items[reference.pictureId]!
        
        return picture
    }
    
    func cleanResources()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncCleanResources()
        }
    }
    
    func removeItem(index:Int)
    {
        let reference:MPicturesItemReference = references.remove(at:index)
        let pictureId:PictureId = reference.pictureId
        items.removeValue(forKey:pictureId)
    }
}
