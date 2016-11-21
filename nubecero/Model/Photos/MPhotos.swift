import Foundation

class MPhotos
{
    typealias AlbumId = String
    typealias PhotoId = String
    
    static let sharedInstance:MPhotos = MPhotos()
    var albumItems:[AlbumId:MPhotosItem]
    var photoDeletables:[MPhotosItemPhoto]
    var albumReferences:[AlbumId]
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
