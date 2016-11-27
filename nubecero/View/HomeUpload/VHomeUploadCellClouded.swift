import UIKit

class VHomeUploadCellClouded:VHomeUploadCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        indicator.image = #imageLiteral(resourceName: "assetHomeSyncDone").withRenderingMode(
            UIImageRenderingMode.alwaysTemplate)
        indicator.tintColor = UIColor.complement
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
