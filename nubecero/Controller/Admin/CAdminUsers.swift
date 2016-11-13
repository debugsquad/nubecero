import UIKit

class CAdminUsers:CController
{
    private weak var viewUsers:VAdminUsers!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminUsers_title", comment:"")
    }
    
    override func loadView()
    {
        let viewUsers:VAdminUsers = VAdminUsers(controller:self)
        self.viewUsers = viewUsers
        view = viewUsers
    }
}
