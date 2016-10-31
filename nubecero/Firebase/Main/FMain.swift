import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let analytics:FAnalytics?
    let database:FDatabase
    let storage:FStorage
    
    private init()
    {
        FIRApp.configure()
        
        #if DEBUG
            
            print("Dry run analytics")
            analytics = nil
            
        #else
            
            analytics = FAnalytics()
        
        #endif
        
        database = FDatabase()
        storage = FStorage()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
