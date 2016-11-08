import UIKit
import FirebaseAuth

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
        do
        {
            try FIRAuth.auth()?.signOut()
        }
        catch
        {
        }
        
        parentController.viewParent.bar.restart()
        
        let controllerLogin:CLogin = CLogin(fetchCredentials:false)
        parentController.over(controller:controllerLogin, pop:true, animate:true)
    }
    
    func rate()
    {
        
    }
}
