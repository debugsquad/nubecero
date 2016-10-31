import Foundation

class MHomeUploadItemStatusSynced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncDone"
    
    override init()
    {
        super.init(assetSync:kAssetSync)
    }
}
