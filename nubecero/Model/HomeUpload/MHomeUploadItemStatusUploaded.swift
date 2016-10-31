import Foundation

class MHomeUploadItemStatusUploaded:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWaiting"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem)
    {
        super.init(item:item, assetSync:kAssetSync, finished:kFinished)
    }
}
