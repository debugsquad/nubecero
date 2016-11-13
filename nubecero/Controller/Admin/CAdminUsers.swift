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
        let path:String = "Users"
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelUser.self)
        { (users) in
            print("done")
        }
    }
}
