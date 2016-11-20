import UIKit

class MHomeUploadItemStatusSynced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncDone"
    private let kFinished:Bool = true
    
    init(item:MHomeUploadItem?)
    {
        let color:UIColor = UIColor.complement
        super.init(
            item:item,
            assetSync:kAssetSync,
            finished:kFinished,
            color:color)
    }
    
    override init(
        item:MHomeUploadItem?,
        assetSync:String,
        finished:Bool,
        color:UIColor)
    {
        fatalError()
    }
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        controller.currentItem += 1
        
        if controller.currentItem < controller.uploadItems.count
        {
            controller.keepSyncing()
        }
        else
        {
            controller.syncComplete()
        }
    }
}
