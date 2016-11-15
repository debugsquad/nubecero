import UIKit

class CAdminPurchases:CController
{
    private weak var viewPurchases:VAdminPurchases!
    
    override func loadView()
    {
        let viewPurchases:VAdminPurchases = VAdminPurchases(controller:self)
        self.viewPurchases = viewPurchases
        view = viewPurchases
    }
}
