import Foundation

class MHomeUploadItemStatusDiskFull:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncError"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        super.init(item:item, assetSync:kAssetSync, finished:kFinished)
    }
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        controller.currentItem += 1
        controller.diskFull()
    }
}