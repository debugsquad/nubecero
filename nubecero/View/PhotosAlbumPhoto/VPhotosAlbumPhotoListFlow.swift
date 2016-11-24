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
}
