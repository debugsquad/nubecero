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
            
                let picturesArray:[FDatabaseModelPicture] = pictureList?.items
            
            else
            {
                self.items = [:]
                self.picturesLoaded()
                
                return
            }
            
            self.comparePictures(picturesArray:picturesArray)
        }
    }
    
    private func comparePictures(picturesArray:[FDatabaseModelPicture])
    {
        for arrayItem:FDatabaseModelPicture in picturesArray
        {
            let arrayItemId:String = arrayItem
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
