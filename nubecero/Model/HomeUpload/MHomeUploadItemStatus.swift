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
    
    deinit
    {
        print("kill \(NSStringFromClass(object_getClass(self)))")
    }
    
    //MARK: public
    
    func process(controller:CHomeUploadSync)
    {
        print("process:: \(NSStringFromClass(object_getClass(self)))")
    }
}
