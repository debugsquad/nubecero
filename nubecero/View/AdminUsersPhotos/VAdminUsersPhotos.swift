import UIKit

class VAdminUsersPhotos:UIView
{
    private weak var controller:CAdminUsersPhotos!
    
    convenience init(controller:CAdminUsersPhotos)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
