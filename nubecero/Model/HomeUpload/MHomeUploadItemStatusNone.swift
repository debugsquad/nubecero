import UIKit

class MHomeUploadItemStatusNone:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncError"
    private let kFinished:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        let color:UIColor = UIColor.main
        super.init(
            item:item,
            assetSync:kAssetSync,
            finished:kFinished,
            color:color)
    }
    
    override init(
        item:MHomeUploadItem?,
        assetSync:String,
        finished:Bool,
        color:UIColor)
    {
        fatalError()
    }
}
