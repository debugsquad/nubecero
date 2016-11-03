import Foundation

class MSessionServer
{
    let froobSpace:Int
    
    init(firebaseServer:FDatabaseModelServer)
    {
        print("loaded server")
        froobSpace = firebaseServer.froobSpace
    }
}
