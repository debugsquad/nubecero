import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let analytics:FAnalytics?
    
    private init()
    {
        #if DEBUG
            
            print("Dry run analytics")
            analytics = nil
            
        #else
            
            analytics = FAnalytics()
        
        #endif
    }
    
    //MARK: public
    
    func load()
    {
    }
}
