import Foundation

class MHomeUploadItemStatusLoaded:MHomeUploadItemStatus
{
    private let kAssetUpload:String = ""
    private let kAssetSync:String = ""
    
    override init()
    {
        super.init(
            assetUpload:kAssetUpload,
            assetSync:kAssetSync)
    }
}