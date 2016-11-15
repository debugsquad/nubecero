import UIKit
import StoreKit

class CStore:CController
{
    private weak var viewStore:VStore!
    
    override func loadView()
    {
        let viewStore:VStore = VStore(controller:self)
        self.viewStore = viewStore
        view = viewStore
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        MStore.sharedInstance.checkAvailability()
        
        SKPaymentQueue.default().add(MStore.sharedInstance)
    }
}
