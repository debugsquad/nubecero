import Foundation
import Firebase

class FAnalytics
{
    private let kEventScreen:NSString = "Screen"
    private let kEventAction:NSString = "Action"
    
    //MARK: public
    
    func screen(controller:CController)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventScreen,
                kFIRParameterItemID:controller.name
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
}
