import UIKit

class VHomeCellDiskGradient:UIView
{
    private let kLocationTop:NSNumber = 0
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
        
        let topColor:CGColor = UIColor.red.cgColor
        let bottomColor:CGColor = UIColor.green.cgColor
        
        gradientLayer.locations = [
            kLocationTop,
            kLocationBottom
        ]
        
        gradientLayer.colors = [
            topColor,
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
