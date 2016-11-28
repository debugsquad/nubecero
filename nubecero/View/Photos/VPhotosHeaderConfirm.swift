import UIKit

class VPhotosHeaderConfirm:UIView
{
    private weak var header:VPhotosHeader!
    
    convenience init(header:VPhotosHeader)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.header = header
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setImage(#imageLiteral(resourceName: "assetHomeAlbumCancel"), for:UIControlState.normal)
        buttonCancel.imageView!.clipsToBounds = true
        buttonCancel.imageView!.contentMode = UIViewContentMode.center
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setImage(#imageLiteral(resourceName: "assetHomeAlbumAdd"), for:UIControlState.normal)
        buttonAdd.imageView!.clipsToBounds = true
        buttonAdd.imageView!.contentMode = UIViewContentMode.center
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonCancel)
        addSubview(buttonAdd)
        
        let views:[String:UIView] = [
            "buttonCancel":buttonCancel,
            "buttonAdd":buttonAdd]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCancel(40)]-5-[buttonAdd(40)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonCancel]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonAdd]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
    
    func actionCancel(sender button:UIButton)
    {
        header.field.textField.text = ""
        UIApplication.shared.keyWindow!.endEditing(true)
        header.cancelAdd()
    }
}
