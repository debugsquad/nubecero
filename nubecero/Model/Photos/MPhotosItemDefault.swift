import Foundation

class MPhotosItemDefault:MPhotosItem
{
    init()
    {
        let name:String = NSLocalizedString("MPhotosItemDefault_name", comment:"")
        super.init(name:name)
    }
    
    override init(name:String)
    {
        fatalError()
    }
}
