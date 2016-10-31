import Foundation

class FDatabaseModel
{
    init()
    {
    }
    
    required init(snapshot:Any?)
    {
        fatalError()
    }
    
    //MARK: public
    
    func modelJson() -> Any
    {
        fatalError()
    }
}
