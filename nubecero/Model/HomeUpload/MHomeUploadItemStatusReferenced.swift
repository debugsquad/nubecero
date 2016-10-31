import Foundation

class MHomeUploadItemStatusReferenced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWaiting"
    
    override init()
    {
        super.init(assetSync:kAssetSync)
    }
}
