import Foundation

class MSessionServer
{
    let froobSpace:Int
    
    init(firebaseServer:FDatabaseModelServer)
    {
        froobSpace = firebaseServer.froobSpace
    }
}
