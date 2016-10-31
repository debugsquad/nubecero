import Foundation

class MHomeUploadItemStatusUploaded:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWaiting"
    private let kFinished:Bool = false
    
    override init()
    {
        super.init(assetSync:kAssetSync, finished:kFinished)
    }
}
