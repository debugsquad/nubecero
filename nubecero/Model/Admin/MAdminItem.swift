import Foundation

class MAdminItem
{
    let title:String
    
    init(title:String)
    {
        self.title = title
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func controller() -> CController
    {
        fatalError()
    }
}
