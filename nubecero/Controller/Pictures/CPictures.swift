import UIKit

class CPictures:CController
{
    weak var viewPictures:VPictures!
    
    override func loadView()
    {
        let viewPictures:VPictures = VPictures(controller:self)
        self.viewPictures = viewPictures
        view = viewPictures
    }
}
