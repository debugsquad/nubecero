import UIKit

class VPhotosAlbumCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(red:0.88, green:0.91, blue:0.93, alpha:1)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MPhotosItemPhoto)
    {
    }
}
