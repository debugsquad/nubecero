import UIKit

class CAdminServer:CController
{
    private weak var viewServer:VAdminServer!
    var model:MAdminServer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminServer_title", comment:"")
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadServer()
        }
    }
    
    override func loadView()
    {
        let viewServer:VAdminServer = VAdminServer(controller:self)
        self.viewServer = viewServer
        view = viewServer
    }
    
    //MARK: private
    
    private func loadServer()
    {
        
    }
}
