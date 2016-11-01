import Foundation

class MPictures
{
    typealias PictureId = String
    
    static let sharedInstance:MPictures = MPictures()
    var items:[PictureId:MPicturesItem]
    
    private init()
    {
        items = [:]
    }
    
    //MARK: private
    
    private func asyncLoadReferences()
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
                self.picturesLoaded()
                
                return
            }
            
            self.comparePictures(picturesMap:picturesMap)
        }
    }
    
    private func comparePictures(picturesMap:[PictureId:FDatabaseModelPicture])
    {
        var items:[PictureId:MPicturesItem] = [:]
        let picturesIds:[PictureId] = Array(picturesMap.keys)
        
        for pictureId:PictureId in picturesIds
        {
            guard
            
                let firebasePicture:FDatabaseModelPicture = picturesMap[pictureId]
            
            else
            {
                continue
            }
            
            if firebasePicture.status == FDatabaseModelPicture.Status.synced
            {
                if let loadedItem:MPicturesItem = self.items[pictureId]
                {
                    items[pictureId] = loadedItem
                }
                else
                {
                    let newItem:MPicturesItem = MPicturesItem(firebasePicture:firebasePicture)
                    items[pictureId] = newItem
                }
            }
        }
        
        self.items = items
        picturesLoaded()
    }
    
    private func picturesLoaded()
    {
        NotificationCenter.default.post(
            name:Notification.picturesLoaded,
            object:nil)
    }
    
    //MARK: public
    
    func loadReferences()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadReferences()
        }
    }
}
