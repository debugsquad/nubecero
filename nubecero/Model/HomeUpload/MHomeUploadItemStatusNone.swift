import Foundation

class MHomeUploadItemStatusNone:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncError"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        super.init(item:item, assetSync:kAssetSync, finished:kFinished)
    }
}
