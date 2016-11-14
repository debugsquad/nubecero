import UIKit
import FirebaseAuth

class CAdminUsers:CController
{
    private weak var viewUsers:VAdminUsers!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminUsers_title", comment:"")
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadUsers()
        }
    }
    
    override func loadView()
    {
        let viewUsers:VAdminUsers = VAdminUsers(controller:self)
        self.viewUsers = viewUsers
        view = viewUsers
    }
    
    //MARK: private
    
    private func loadUsers()
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        
        FMain.sharedInstance.database.listenOnce(
            path:parentUser,
            modelType:FDatabaseModelUserList.self)
        { [weak self] (users) in
            
            guard
            
                let usersStrong:FDatabaseModelUserList = users
            
            else
            {
                let errorString:String = NSLocalizedString("CAdminUsers_errorLoading", comment:"")
                self?.loadingError(error:errorString)
                
                return
            }
            
            
        }
    }
    
    private func loadingError(error:String)
    {
        VAlert.message(message:error)
        
        DispatchQueue.main.async
        { [weak self] in

            self?.viewUsers.loadingError()
        }
    }
}
