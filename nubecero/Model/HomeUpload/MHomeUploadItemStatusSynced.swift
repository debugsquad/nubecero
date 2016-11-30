import UIKit

class MHomeUploadItemStatusSynced:MHomeUploadItemStatus
{
    private let kAssetSync:String = "assetHomeSyncDone"
    private let kFinished:Bool = true
    private let kSelectable:Bool = false
    
    init(item:MHomeUploadItem?)
    {
        let reusableIdentifier:String = VHomeUploadCellActive.reusableIdentifier
        let color:UIColor = UIColor.complement
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
    
    override func process(controller:CHomeUploadSync)
    {
        super.process(controller:controller)
        
        controller.currentItem += 1
        
        if controller.currentItem < controller.uploadItems.count
        {
            controller.keepSyncing()
        }
        else
        {
            controller.syncComplete()
        }
    }
}
