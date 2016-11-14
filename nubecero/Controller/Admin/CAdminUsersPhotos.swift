import UIKit

class CAdminUsersPhotos:CController
{
    private weak var viewPhotos:VAdminUsersPhotos!
    let model:MAdminUsersItem
    
    init(model:MAdminUsersItem)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminUsersPhotos_title", comment:"")
    }
    
    override func loadView()
    {
        let viewPhotos:VAdminUsersPhotos = VAdminUsersPhotos(controller:self)
        self.viewPhotos = viewPhotos
        view = viewPhotos
    }
}
