import Foundation

class MHomeUploadItemStatusNone:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncError"
    private let kFinished:Bool = false
    
    override init()
    {
        super.init(assetSync:kAssetSync, finished:kFinished)
    }
}
