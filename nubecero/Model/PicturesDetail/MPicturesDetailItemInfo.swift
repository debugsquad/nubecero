import Foundation

class MPicturesDetailItemInfo:MPicturesDetailItem
{
    private let kSizeWeight:Int = 1
 
    override init()
    {
        let reusableIdentifier:String = VPicturesDetailCellInfo.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            sizeWeight:kSizeWeight)
    }
    
    override init(reusableIdentifier:String, sizeWeight:Int)
    {
        fatalError()
    }
}
