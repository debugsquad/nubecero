import UIKit

class CAdminServer:CController
{
    private weak var viewServer:VAdminServer!
    
    override func loadView()
    {
        let viewServer:VAdminServer = VAdminServer(controller:self)
        self.viewServer = viewServer
        view = viewServer
    }
}
