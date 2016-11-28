import UIKit

class VHomeUploadCellActive:VHomeUploadCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        indicator.image = #imageLiteral(resourceName: "assetHomeUploadSelect")
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
