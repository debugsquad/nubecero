import Foundation

class MHomeUploadItemStatusWaiting:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWaiting"
    
    override init()
    {
        super.init(assetSync:kAssetSync)
    }
}
