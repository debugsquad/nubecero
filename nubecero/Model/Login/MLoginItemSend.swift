import UIKit

class MLoginItemSend:MLoginItem
{
    private let kCellHeight:CGFloat = 40
    private let kSelectable:Bool = true
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
    
    override init()
    {
        let reusableIdentifier:String = VLoginCellSend.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override func selected(controller:CLogin)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.sendLogin()
    }
}
