import UIKit

class CAdminPurchases:CController
{
    private weak var viewPurchases:VAdminPurchases!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminPurchases_title", comment:"")
    }
    
    override func loadView()
    {
        let viewPurchases:VAdminPurchases = VAdminPurchases(controller:self)
        self.viewPurchases = viewPurchases
        view = viewPurchases
    }
}
