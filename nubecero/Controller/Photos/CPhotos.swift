import UIKit

class CPhotos:CController
{
    private weak var viewPhotos:VPhotos!
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
        MPhotos.sharedInstance.cleanResources()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedPhotosLoaded(sender:)),
            name:Notification.photosLoaded,
            object:nil)
        
        MPhotos.sharedInstance.loadPhotos()
    }
    
    override func loadView()
    {
        let viewPhotos:VPhotos = VPhotos(controller:self)
        self.viewPhotos = viewPhotos
        view = viewPhotos
    }
    
    //MARK: notified
    
    func notifiedPhotosLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPhotos.photosLoaded()
        }
    }
    
    //MARK: private
    
    private func asyncNewAlbum(name:String)
    {
        guard
          
            let userId:MSession.UserId = MSession.sharedInstance.user.userId
        
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyAlbums:String = FDatabaseModelUser.Property.albums.rawValue
        let albumsPath:String = "\(parentUser)/\(userId)/\(propertyAlbums)"
        let modelAlbum:FDatabaseModelAlbum = FDatabaseModelAlbum(name:name)
        let jsonAlbum:Any = modelAlbum.modelJson()
        
        let _:MPhotos.AlbumId = FMain.sharedInstance.database.createChild(
            path:albumsPath,
            json:jsonAlbum)
        
        MPhotos.sharedInstance.loadPhotos()
    }
    
    //MARK: public
    
    func selected(item:MPhotosItem)
    {
        let albumController:CPhotosAlbum = CPhotosAlbum(model:item)
        parentController.scrollRight(
            controller:albumController,
            underBar:false,
            pop:false)
    }
    
    func newAlbum(name:String)
    {
        viewPhotos.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncNewAlbum(name:name)
        }
    }
}
