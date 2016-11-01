import UIKit

class VPicturesDetail:UIView
{
    private weak var controller:CPictures!
    
    convenience init(controller:CPictures)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    //MARK: public
    
    func refresh()
    {
    }
}
