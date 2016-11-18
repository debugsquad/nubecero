import UIKit

class CAdminUsersPhotos:CController
{
    private weak var viewPhotos:VAdminUsersPhotos!
    private let model:MAdminUsersItem
    var photos:MAdminUsersPhotos?
    
    init(model:MAdminUsersItem)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminUsersPhotos_title", comment:"")
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadPhotos()
        }
    }
    
    override func loadView()
    {
        let viewPhotos:VAdminUsersPhotos = VAdminUsersPhotos(controller:self)
        self.viewPhotos = viewPhotos
        view = viewPhotos
    }
    
    //MARK: private
    
    private func loadPhotos()
    {
        let userId:MSession.UserId = model.userId
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let pathPhotos:String = "\(parentUser)/\(userId)/\(propertyPhotos)"
        
        FMain.sharedInstance.database.listenOnce(
            path:pathPhotos,
            modelType:FDatabaseModelPhotoList.self)
        { [weak self] (photos) in
            
            guard
            
                let photosStrong:FDatabaseModelPhotoList = photos
            
            else
            {
                let errorString:String = NSLocalizedString("CAdminUsersPhotos_errorLoading", comment:"")
                self?.loadingError(error:errorString)
                
                return
            }
            
            self?.photos = MAdminUsersPhotos(userId:userId, photoList:photosStrong)
            self?.loadingCompleted()
        }
    }
    
    private func loadingError(error:String)
    {
        VAlert.message(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPhotos.loadingError()
        }
    }
    
    private func loadingCompleted()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPhotos.loadingFinished()
        }
    }
}
