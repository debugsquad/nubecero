import Foundation

class MHomeUploadItemStatus
{
    let assetUpload:String
    let assetSync:String
    
    init(assetUpload:String, assetSync:String)
    {
        self.assetSync = assetSync
        self.assetUpload = assetUpload
    }
}
