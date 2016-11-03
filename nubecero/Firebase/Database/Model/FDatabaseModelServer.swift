import Foundation

class FDatabaseModelServer:FDatabaseModel
{
    enum Property:String
    {
        case froobSpace = "froobSpace"
    }
    
    let froobSpace:Int
    private let kNoSpace:Int = 0
    
    init(froobSpace:Int)
    {
        self.froobSpace = froobSpace
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        
        if let froobSpace:Int = snapshotDict?[Property.froobSpace.rawValue] as? Int
        {
            self.froobSpace = froobSpace
        }
        else
        {
            self.froobSpace = kNoSpace
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.froobSpace.rawValue:froobSpace
        ]
        
        return json
    }
}
