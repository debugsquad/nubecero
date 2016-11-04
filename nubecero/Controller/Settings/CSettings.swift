import UIKit
import FBSDKLoginKit

class CSettings:CController
{
    private weak var viewSettings:VSettings!
    let model:MSettings
    
    init()
    {
        model = MSettings()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
    
    //MARK: public
    
    func logOut()
    {
        let manager:FBSDKLoginManager = FBSDKLoginManager()
        manager.logOut()
        
        let controllerLogin:CLogin = CLogin()
//        parentController.over(controller:controllerLogin, pop:true, animate:false)
    }
}
