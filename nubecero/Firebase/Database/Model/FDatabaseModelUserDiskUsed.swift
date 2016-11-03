import Foundation

class FDatabaseModelUserDiskUsed:FDatabaseModel
{
    let diskUsed:Int
    
    required init(snapshot:Any)
    {
        if let diskUsed:Int = snapshot as? Int
        {
            self.diskUsed = diskUsed
        }
        else
        {
            self.diskUsed = 0
        }
        
        super.init()
    }
}
