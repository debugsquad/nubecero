import UIKit

class VAdminUsers:UIView
{
    private weak var controller:CAdminUsers!
    private weak var spinner:VSpinner!
    
    convenience init(controller:CAdminUsers)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(spinner)
        
        let views:[String:UIView] = [
            "spinner":spinner]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: public
    
    func loadingError()
    {
        spinner.removeFromSuperview()
    }
    
    func loadingCompleted()
    {
        spinner.removeFromSuperview()
    }
}
