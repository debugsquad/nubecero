import Foundation

class MHomeUploadItemStatusUploaded:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncWaiting"
    
    override init()
    {
        super.init(assetSync:kAssetSync)
    }
}
