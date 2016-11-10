import Foundation

class MPicturesDetailItemImage:MPicturesDetailItem
{
    private let kSizeWeight:Int = 9
    
    override init()
    {
        let reusableIdentifier:String = VPicturesDetailCellImage.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            sizeWeight:kSizeWeight)
    }
    
    override init(reusableIdentifier:String, sizeWeight:Int)
    {
        fatalError()
    }
}
