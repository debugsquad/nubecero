import Foundation

class FDatabaseModelUserStatus:FDatabaseModel
{
    let status:FDatabaseModelUser.Status
    
    required init(snapshot:Any)
    {
        if let statusInt:Int = snapshot as? Int
        {
            if let status:FDatabaseModelUser.Status = FDatabaseModelUser.Status(
                rawValue:statusInt)
            {
                self.status = status
            }
            else
            {
                self.status = FDatabaseModelUser.Status.unknown
            }
        }
        else
        {
            self.status = FDatabaseModelUser.Status.unknown
        }
        
        super.init()
    }
}
