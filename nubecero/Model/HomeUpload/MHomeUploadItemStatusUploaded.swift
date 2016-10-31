import Foundation

class MHomeUploadItemStatusUploaded:MHomeUploadItemStatus
{
    private let kAssetUpload:String = ""
    private let kAssetSync:String = ""
    
    init()
    {
        super.init(
            assetUpload:kAssetUpload,
            assetSync:kAssetSync)
    }
}
