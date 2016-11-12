import UIKit

class CAdmin:CController
{
    private weak var viewAdmin:VAdmin!
    
    override func loadView()
    {
        let viewAdmin:VAdmin = VAdmin(controller:self)
        self.viewAdmin = viewAdmin
        view = viewAdmin
    }
}
