import UIKit

class CAdminUsersPhotos:CController
{
    private weak var viewPhotos:VAdminUsersPhotos!
    private let model:MAdminUsersItem
    var pictures:MAdminUsersPhotos?
    
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
            
            self?.loadPictures()
        }
    }
    
    override func loadView()
    {
        let viewPhotos:VAdminUsersPhotos = VAdminUsersPhotos(controller:self)
        self.viewPhotos = viewPhotos
        view = viewPhotos
    }
    
    //MARK: private
    
    private func loadPictures()
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPictures:String = FDatabaseModelUser.Property.pictures.rawValue
        let pathPictures:String = "\(parentUser)/\(model.userId)/\(propertyPictures)"
        
        FMain.sharedInstance.database.listenOnce(
            path:pathPictures,
            modelType:FDatabaseModelPictureList.self)
        { [weak self] (pictures) in
            
            guard
            
                let picturesStrong:FDatabaseModelPictureList = pictures
            
            else
            {
                let errorString:String = NSLocalizedString("CAdminUsersPhotos_errorLoading", comment:"")
                self?.loadingError(error:errorString)
                
                return
            }
            
            self?.pictures = MAdminUsersPhotos(userId:model.userId, pictureList:picturesStrong)
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
