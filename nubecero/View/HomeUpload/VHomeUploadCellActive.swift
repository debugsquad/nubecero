import UIKit

class VHomeUploadCellActive:VHomeUploadCell
{
    override init(frame:CGRect)
    {
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        
        super.init(frame:frame, blurEffect:blurEffect)
        indicator.image = #imageLiteral(resourceName: "assetHomeUploadSelect")
    }
    
    override init(frame:CGRect, blurEffect:UIBlurEffect)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            baseBlur.isHidden = false
            indicator.isHidden = false
        }
        else
        {
            baseBlur.isHidden = true
            indicator.isHidden = true
        }
    }
    
    //MARK: public
    
    override func config(model:MHomeUploadItem)
    {
        super.config(model:model)
        hover()
    }
}
