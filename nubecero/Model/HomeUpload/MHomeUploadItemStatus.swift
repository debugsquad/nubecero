import UIKit

class MHomeUploadItemStatus
{
    let reusableIdentifier:String
    let assetSync:String
    let finished:Bool
    let selectable:Bool
    let color:UIColor
    weak var item:MHomeUploadItem?
    
    init(
        reusableIdentifier:String,
        item:MHomeUploadItem?,
        assetSync:String,
        finished:Bool,
        selectable:Bool,
        color:UIColor)
    {
        self.reusableIdentifier = reusableIdentifier
        self.item = item
        self.assetSync = assetSync
        self.finished = finished
        self.selectable = selectable
        self.color = color
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func process(controller:CHomeUploadSync)
    {
    }
}
