import UIKit

class VPhotosAlbumPhotoListFlow:UICollectionViewFlowLayout
{
    override init()
    {
        super.init()
        headerReferenceSize = CGSize.zero
        footerReferenceSize = CGSize.zero
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.horizontal
        sectionInset = UIEdgeInsets.zero
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath:IndexPath) -> UICollectionViewLayoutAttributes?
    {
        let attributes:UICollectionViewLayoutAttributes? = layoutAttributesForItem(
            at:itemIndexPath)
        attributes?.alpha = 1
        
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath:IndexPath) -> UICollectionViewLayoutAttributes?
    {
        let attributes:UICollectionViewLayoutAttributes? = layoutAttributesForItem(
            at:itemIndexPath)
        attributes?.alpha = 1
        
        return attributes
    }
}
