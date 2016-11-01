import Foundation

class MPictures
{
    static let sharedInstance:MPictures = MPictures()
    var items:[String:MPicturesItem]
    
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
            
                let picturesMap:[String:FDatabaseModelPicture] = pictureList?.items
            
            else
            {
                self.items = [:]
                self.picturesLoaded()
                
                return
            }
            
            self.comparePictures(picturesMap:picturesMap)
        }
    }
    
    private func comparePictures(picturesMap:[String:FDatabaseModelPicture])
    {
        var items:[String:]
        let picturesIds:[String] = Array(picturesMap.keys)
        
        for pictureId:String in picturesIds
        {
            guard
            
                let firebasePicture:FDatabaseModelPicture = picturesMap[pictureId]
            
            else
            {
                continue
            }
            
            if firebasePicture.status == FDatabaseModelPicture.Status.synced
            {
                
            }
        }
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
