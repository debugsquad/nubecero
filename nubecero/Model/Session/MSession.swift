import Foundation

class MSession
{
    enum Status:Int
    {
        case unknown
        case active
        case banned
    }
    
    typealias UserId = String
    
    static let sharedInstance:MSession = MSession()
    let user:MSessionUser
    let settings:MSessionSettings
    let server:MSessionServer
    let version:String
    private let kVersionKey:String = "CFBundleVersion"
    private let kEmpty:String = ""
    
    private init()
    {
        user = MSessionUser()
        settings = MSessionSettings()
        server = MSessionServer()
        
        if let version:String = Bundle.main.infoDictionary?[kVersionKey] as? String
        {
            self.version = version
        }
        else
        {
            self.version = kEmpty
        }
    }
}
