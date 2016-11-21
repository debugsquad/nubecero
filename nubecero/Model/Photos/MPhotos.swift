import Foundation

class MPhotos
{
    typealias AlbumId = String
    typealias PhotoId = String
    
    static let sharedInstance:MPhotos = MPhotos()
    var albumItems:[AlbumId:MPhotosItem]
    var photoDeletables:[MPhotosItemPhoto]
    var albumReferences:[MPhotosItemReference]
    private var photos:[PhotoId:MPhotosItemPhoto]
    private var loading:Bool
    
    private init()
    {
        loading = false
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
        var items:[AlbumId:MPhotosItem] = [:]
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
            
            if let loadedItem:MPhotosItem = self.albumItems[albumId]
            {
                items[albumId] = loadedItem
            }
            else
            {
                let newItem:MPhotosItem = MPhotosItem(
                    albumId:albumId,
                    firebaseAlbum:firebaseAlbum)
                
                items[albumId] = newItem
            }
            
            let albumReference:MPhotosItemReference = MPhotosItemReference(
                albumId:albumId,
                name:albumName)
            
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
                self.albumItems = [:]
                self.photoDeletables = []
                self.albumReferences = []
                self.photos = [:]
                self.picturesLoaded()
                
                return
            }
            
            self.comparePhotos(photosMap:photosMap)
        }
    }
    
    private func comparePhotos(photosMap:[PhotoId:FDatabaseModelPhoto])
    {
        var items:[PictureId:MPicturesItem] = [:]
        var references:[MPicturesItemReference] = []
        let picturesIds:[PictureId] = Array(picturesMap.keys)
        
        for pictureId:PictureId in picturesIds
        {
            guard
                
                let firebasePicture:FDatabaseModelPicture = picturesMap[pictureId]
                
                else
            {
                continue
            }
            
            let pictureStatus:FDatabaseModelPicture.Status = firebasePicture.status
            let pictureCreated:TimeInterval = firebasePicture.created
            
            if pictureStatus == FDatabaseModelPicture.Status.synced
            {
                if let loadedItem:MPicturesItem = self.items[pictureId]
                {
                    items[pictureId] = loadedItem
                }
                else
                {
                    let newItem:MPicturesItem = MPicturesItem(
                        pictureId:pictureId,
                        firebasePicture:firebasePicture)
                    items[pictureId] = newItem
                }
                
                let pictureReference:MPicturesItemReference = MPicturesItemReference(
                    pictureId:pictureId,
                    created:pictureCreated)
                
                references.append(pictureReference)
            }
            else
            {
                let deleteItem:MPicturesItem = MPicturesItem(
                    pictureId:pictureId,
                    firebasePicture:firebasePicture)
                deletable.append(deleteItem)
            }
        }
        
        references.sort
            { (referenceA, referenceB) -> Bool in
                
                let createdA:TimeInterval = referenceA.created
                let createdB:TimeInterval = referenceB.created
                
                return createdA > createdB
        }
        
        self.items = items
        self.references = references
        picturesLoaded()
    }
    
    private func picturesLoaded()
    {
        NotificationCenter.default.post(
            name:Notification.picturesLoaded,
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
