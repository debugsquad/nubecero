import UIKit

class MHomeUploadItemStatus
{
    let assetSync:String
    let finished:Bool
    weak var item:MHomeUploadItem?
    
    init()
    {
        fatalError()
    }
    
    init(item:MHomeUploadItem?, assetSync:String, finished:Bool)
    {
        self.item = item
        self.assetSync = assetSync
        self.finished = finished
    }
    
    //MARK: public
    
    func process(controller:CHomeUploadSync)
    {
    }
}
