import Foundation

class MHomeUploadItemStatusLoaded:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWaiting"
    
    override init()
    {
        super.init(assetSync:kAssetSync)
    }
}
