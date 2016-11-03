import UIKit

class CBanned:CController
{
    weak var viewBanned:VBanned!
    
    override func loadView()
    {
        let viewBanned:VBanned = VBanned(controller:self)
        self.viewBanned = viewBanned
        view = viewBanned
    }
}
