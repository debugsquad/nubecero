import UIKit

class CAuth:CController
{
    weak var viewAuth:VAuth!
    
    override func loadView()
    {
        let viewAuth:VAuth = VAuth(controller:self)
        self.viewAuth = viewAuth
        view = viewAuth
    }
}
