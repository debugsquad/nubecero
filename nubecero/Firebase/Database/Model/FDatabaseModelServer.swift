import Foundation

class FDatabaseModelServer:FDatabaseModel
{
    enum Property:String
    {
        case froobSpace = "froobSpace"
        case plusSpace = "plusSpace"
    }
    
    let froobSpace:Int
    let plusSpace:Int
    private let kNoSpace:Int = 0
    
    init(froobSpace:Int, plusSpace:Int)
    {
        self.froobSpace = froobSpace
        self.plusSpace = plusSpace
        
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
        
        if let plusSpace:Int = snapshotDict?[Property.plusSpace.rawValue] as? Int
        {
            self.plusSpace = plusSpace
        }
        else
        {
            self.plusSpace = kNoSpace
        }
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.froobSpace.rawValue:froobSpace,
            Property.plusSpace.rawValue:plusSpace
        ]
        
        return json
    }
}
