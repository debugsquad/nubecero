import Foundation

class MSessionServer
{
    let froobSpace:Int
    let plusSpace:Int
    
    init(firebaseServer:FDatabaseModelServer)
    {
        froobSpace = firebaseServer.froobSpace
        plusSpace = firebaseServer.plusSpace
    }
}
