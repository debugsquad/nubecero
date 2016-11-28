import UIKit

class VHomeUploadCellClouded:VHomeUploadCell
{
    override init(frame:CGRect)
    {
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.dark)
        
        super.init(frame:frame, blurEffect:blurEffect)
        isUserInteractionEnabled = false
        indicator.image = #imageLiteral(resourceName: "assetHomeSyncDone")
    }
    
    override init(frame:CGRect, blurEffect:UIBlurEffect)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
