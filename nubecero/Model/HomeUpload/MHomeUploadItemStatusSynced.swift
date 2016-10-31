import Foundation

class MHomeUploadItemStatusSynced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncDone"
    private let kFinished:Bool = true
    
    override init()
    {
        super.init(assetSync:kAssetSync, finished:kFinished)
    }
}
