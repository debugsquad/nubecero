import UIKit

class MHomeUploadItemStatus
{
    let assetSync:String
    let finished:Bool
    let color:UIColor
    weak var item:MHomeUploadItem?
    
    init(
        item:MHomeUploadItem?,
        assetSync:String,
        finished:Bool,
        color:UIColor)
    {
        self.item = item
        self.assetSync = assetSync
        self.finished = finished
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
