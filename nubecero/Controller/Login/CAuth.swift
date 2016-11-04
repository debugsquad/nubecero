import UIKit
import LocalAuthentication

class CAuth:CController
{
    private weak var viewAuth:VAuth!
    
    override func loadView()
    {
        let viewAuth:VAuth = VAuth(controller:self)
        self.viewAuth = viewAuth
        view = viewAuth
    }
    
    //MARK: private
    
    private func authSuccess()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController.dismiss()
        }
    }
    
    private func authError(error:String)
    {
        VAlert.message(message:error)
    }
    
    //MARK: public
    
    func askAuth()
    {
        let laContext:LAContext = LAContext()
        
        laContext.evaluatePolicy(
            LAPolicy.deviceOwnerAuthentication,
            localizedReason:"Just for fun")
        { [weak self] (success, error) in
            
            if success
            {
                self?.authSuccess()
            }
            else
            {
                if let errorString:String = error?.localizedDescription
                {
                    self?.authError(error:errorString)
                }
                else
                {
                    let errorString:String = NSLocalizedString("CAuth_errorUnknown", comment:"")
                    self?.authError(error:errorString)
                }
            }
        }
        
        /*
        let myContext = LAContext()
        let myLocalizedReasonString = "just for shit"
        
        var authError: NSError? = nil
        if #available(iOS 8.0, OSX 10.12, *) {
            if myContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { (success, evaluateError) in
                    if (success) {
                        
                        DispatchQueue.main.async {
                            self.parentController.dismiss()
                        }
                        // User authenticated successfully, take appropriate action
                    } else {
                        VAlert.message(message:evaluateError!.localizedDescription)
                        // User did not authenticate successfully, look at error and take appropriate action
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
            }
        } else {
            // Fallback on earlier versions
        }*/
    }
}
