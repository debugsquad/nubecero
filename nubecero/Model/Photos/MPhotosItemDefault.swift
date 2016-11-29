import Foundation

class MPhotosItemDefault:MPhotosItem
{
    private let kEmpty:String = ""
    
    init()
    {
        let name:String = NSLocalizedString("MPhotosItemDefault_name", comment:"")
        super.init(name:name)
    }
    
    override init(name:String)
    {
        fatalError()
    }
    
    override func moveToSelf(path:String)
    {
        FMain.sharedInstance.database.updateChild(
            path:path,
            json:kEmpty)
    }
}
