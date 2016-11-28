import UIKit

class VHomeUploadCellClouded:VHomeUploadCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        indicator.image = #imageLiteral(resourceName: "assetHomeSyncDone")
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
