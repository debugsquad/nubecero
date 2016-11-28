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
        
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
    
    func actionCancel(sender button:UIButton)
    {
        controller.view
        UIApplication.shared.keyWindow!.endEditing(true)
    }
}
