import Foundation

class MHomeUploadItemStatusNone:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncError"
    
    override init()
    {
        super.init(assetSync:kAssetSync)
    }
}
