import UIKit

class VHomeUpload:UIView
{
    weak var controller:CHomeUpload!
    weak var spinner:VSpinner!
    
    convenience init(controller:CHomeUpload)
    {
        self.init()
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
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
    
    func showError()
    {
        spinner.stopAnimating()
        
        let errorImage:UIImageView = UIImageView()
        errorImage.isUserInteractionEnabled = false
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorImage.clipsToBounds = true
        errorImage.contentMode = UIViewContentMode.center
        errorImage.image = #imageLiteral(resourceName: "assetGenericError")
        
        addSubview(errorImage)
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let views:[String:UIView] = [
            "errorImage":errorImage]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[errorImage]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[errorImage]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
