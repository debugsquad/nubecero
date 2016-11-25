import UIKit

class CAdmin:CController
{
    private weak var viewAdmin:VAdmin!
    let model:MAdmin
    
    override init()
    {
        model = MAdmin()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewAdmin:VAdmin = VAdmin(controller:self)
        self.viewAdmin = viewAdmin
        view = viewAdmin
    }
    
    //MARK: public
    
    func selected(item:MAdminItem)
    {
        let controller:CController = item.controller()
        parentController.push(
            controller:controller,
            underBar:true)
    }
}
