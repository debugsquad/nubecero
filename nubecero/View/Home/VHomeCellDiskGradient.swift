import UIKit

class VHomeCellDiskGradient:UIView
{
    private let kLocationTop:NSNumber = 0
    private let kLocationMiddle:NSNumber = 0.5
    private let kLocationBottom:NSNumber = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        guard
        
            let gradientLayer:CAGradientLayer = self.layer as? CAGradientLayer
        
        else
        {
            return
        }
        
        let yellowColor:UIColor = UIColor(
            red:0.980392156862745,
            green:0.735294117647059,
            blue:0.288235294117647,
            alpha:1)
        
        let topColor:CGColor = yellowColor.cgColor
        let middleColor:CGColor = UIColor.main.cgColor
        let bottomColor:CGColor = yellowColor.cgColor
        
        gradientLayer.locations = [
            kLocationTop,
            kLocationMiddle,
            kLocationBottom
        ]
        
        gradientLayer.colors = [
            topColor,
            middleColor,
            bottomColor
        ]
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override open class var layerClass:AnyClass
    {
        get
        {
            return CAGradientLayer.self
        }
    }
}
