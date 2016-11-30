import UIKit

class MHomeUploadItemStatusClouded:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncDone"
    private let kFinished:Bool = false
    private let kSelectable:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        let reusableIdentifier:String = VHomeUploadCellClouded.reusableIdentifier
        let color:UIColor = UIColor.main
        super.init(
            reusableIdentifier:reusableIdentifier,
            item:item,
            assetSync:kAssetSync,
            finished:kFinished,
            selectable:kSelectable,
            color:color)
    }
    
    override init(
        reusableIdentifier:String,
        item:MHomeUploadItem?,
        assetSync:String,
        finished:Bool,
        selectable:Bool,
        color:UIColor)
    {
        fatalError()
    }
}
