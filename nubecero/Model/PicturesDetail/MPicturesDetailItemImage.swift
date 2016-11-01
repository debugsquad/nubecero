import Foundation

class MPicturesDetailItemImage:MPicturesDetailItem
{
    private let kSizeWeight:Int = 7
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDetailCellImage.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            sizeWeight:kSizeWeight)
    }
}
