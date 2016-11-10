import UIKit
import FirebaseAuth

class CSettings:CController
{
    private let kRateUrl:String = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1012571476&type=Purple+Software&mt=8"
    private let kShareUrl:String = "https://itunes.apple.com/us/app/nubecero/id1012571476"
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
        
        let controllerOnboard:COnboard = COnboard()
        parentController.over(controller:controllerOnboard, pop:true, animate:true)
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
    
    func share()
    {
        guard
            
            let url:URL = URL(string:kShareUrl)
            
        else
        {
            return
        }
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[url],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewSettings
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
}
