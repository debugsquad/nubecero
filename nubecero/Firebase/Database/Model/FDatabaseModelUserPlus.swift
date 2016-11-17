import Foundation

class FDatabaseModelUserPlus:FDatabaseModel
{
    let plus:Bool
    
    required init(snapshot:Any)
    {
        if let plus:Bool = snapshot as? Bool
        {
            self.plus = plus
        }
        else
        {
            self.plus = false
        }
        
        super.init()
    }
    
    override init()
    {
        plus = true
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:Any = plus
        
        return json
    }
}
