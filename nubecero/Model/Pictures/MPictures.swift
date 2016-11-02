import Foundation

class MPictures
{
    typealias PictureId = String
    
    static let sharedInstance:MPictures = MPictures()
    var references:[MPicturesItemReference]
    private var items:[PictureId:MPicturesItem]
    
    private init()
    {
        items = [:]
        references = []
    }
    
    //MARK: private
    
    private func asyncLoadPictures()
    {
        guard
            
            let userId:String = MSession.sharedInstance.userId
        
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPictures:String = FDatabaseModelUser.Property.pictures.rawValue
        let path:String = "\(parentUser)/\(userId)/\(propertyPictures)"
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelPictureList.self)
        { (pictureList) in
            
            guard
            
                let picturesMap:[PictureId:FDatabaseModelPicture] = pictureList?.items
            
            else
            {
                self.items = [:]
                self.references = []
                self.picturesLoaded()
                
                return
            }
            
            self.comparePictures(picturesMap:picturesMap)
        }
    }
    
    private func comparePictures(picturesMap:[PictureId:FDatabaseModelPicture])
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
        }
        
        references.sort()
        { (referenceA, referenceB) -> Bool in
            
            let createdA:TimeInterval = referenceA.created
            let createdB:TimeInterval = referenceB.created
            
            return createdA < createdB
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
    
    //MARK: public
    
    func loadPictures()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadPictures()
        }
    }
    
    func pictureAtIndex(index:Int) -> MPicturesItem
    {
        let reference:MPicturesItemReference = references[index]
        let picture:MPicturesItem = items[reference.pictureId]!
        
        return picture
    }
}
