import UIKit
import FirebaseAuth

class CSettings:CController
{
    private let kRateUrl:String = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1012571476&type=Purple+Software&mt=8"
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
        guard
            
            let url:URL = URL(string:kRateUrl)
        
        else
        {
            return
        }
        
        UIApplication.shared.openURL(url)
    }
}
