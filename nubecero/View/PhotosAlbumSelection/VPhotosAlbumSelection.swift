import UIKit

class VPhotosAlbumSelection:UIView
{
    private weak var controller:CPhotosAlbumSelection!
    private weak var collectionView:UICollectionView!
    
    convenience init(controller:CPhotosAlbumSelection)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isUserInteractionEnabled = false
        visualEffect.clipsToBounds = true
        
        addSubview(visualEffect)
        
        
    }
}
