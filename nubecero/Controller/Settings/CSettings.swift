import UIKit
import FBSDKLoginKit
import FBSDKShareKit
import FirebaseAuth

class CSettings:CController, FBSDKAppInviteDialogDelegate
{
    private weak var viewSettings:VSettings!
    private let kStringUrl:String = "https://itunes.apple.com/us/app/nubecero/id1012571476"
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
        
        do
        {
            try FIRAuth.auth()?.signOut()
        }
        catch
        {
        }
        
        parentController.viewParent.bar.restart()
        
        let controllerLogin:CLogin = CLogin()
        parentController.over(controller:controllerLogin, pop:true, animate:true)
    }
    
    func facebookInvite()
    {
        guard
            
            let url:URL = URL(string:kStringUrl)
            
        else
        {
            return
        }
        
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        
        if inviteDialog.canShow()
        {
            let content:FBSDKAppInviteContent = FBSDKAppInviteContent()
            content.appLinkURL = url
            inviteDialog.delegate = self
            inviteDialog.content = content
            inviteDialog.fromViewController = self
            inviteDialog.show()
        }
        else
        {
            let message:String = NSLocalizedString("CSettings_cantInvite", comment:"")
            VAlert.message(message:message)
        }
    }
    
    //MARK: fbsdk invite delegate
    
    func appInviteDialog(_ appInviteDialog:FBSDKAppInviteDialog!, didFailWithError error:Error!)
    {
    }
    
    func appInviteDialog(_ appInviteDialog:FBSDKAppInviteDialog!, didCompleteWithResults results:[AnyHashable:Any]!)
    {
    }
}
