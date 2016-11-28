import UIKit

class VHomeUploadCellClouded:VHomeUploadCell
{
    private let kBlurAlpha:CGFloat = 0.8
    
    override init(frame:CGRect)
    {
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.dark)
        
        super.init(frame:frame, blurEffect:blurEffect, blurAlpha:kBlurAlpha)
        isUserInteractionEnabled = false
        indicator.image = #imageLiteral(resourceName: "assetHomeSyncDone")
    }
    
    override init(frame:CGRect, blurEffect:UIBlurEffect, blurAlpha:CGFloat)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
