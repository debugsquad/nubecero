import Foundation

class MPicturesDetailItem
{
    let reusableIdentifier:String
    let sizeWeight:Int
    
    init()
    {
        fatalError()
    }
    
    init(reusableIdentifier:String, sizeWeight:Int)
    {
        self.reusableIdentifier = reusableIdentifier
        self.sizeWeight = sizeWeight
    }
}
