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
            localizedReason:NSLocalizedString("CAuth_reason", comment:""))
        { [weak self] (success, error) in
            
            if success
            {
                self?.authSuccess()
            }
            else
            {
                if let errorLA:LAError = error as? LAError
                {
                    if errorLA.code == LAError.Code.passcodeNotSet
                    {
                        self?.authSuccess()
                        
                        let notSet:String = NSLocalizedString("CAuth_passCodeNotSet", comment:"")
                        VAlert.message(message:notSet)
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
                else
                {
                    let errorString:String = NSLocalizedString("CAuth_errorUnknown", comment:"")
                    self?.authError(error:errorString)
                }
            }
        }
    }
}
