import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    var firebaseUser:FDatabaseModelUser?
    
    private init()
    {
    }
    
    //MARK: private
    
    
    //MARK: public
    
    func loadUser()
    {
    }
}
