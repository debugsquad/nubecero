import Foundation

class FDatabaseModelToken:FDatabaseModel
{
    let token:String
    private let kEmpty:String = ""
    
    init(token:String)
    {
        self.token = token
        
        super.init()
    }
    
    required init(snapshot:Any)
    {
        fatalError()
    }
    
    override init()
    {
        fatalError()
    }
    
    override func modelJson() -> Any
    {
        return token
    }
}
