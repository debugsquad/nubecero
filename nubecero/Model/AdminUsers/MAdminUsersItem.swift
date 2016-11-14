import Foundation

class MAdminUsersItem
{
    let userId:MSession.UserId
    let created:TimeInterval
    let lastSession:TimeInterval
    let diskUsed:Int
    let status:FDatabaseModelUser.Status
    
    init(userId:MSession.UserId, firebaseUser:FDatabaseModelUser)
    {
        self.userId = userId
        created = firebaseUser.created
        lastSession = firebaseUser.lastSession
        diskUsed = firebaseUser.diskUsed
        status = firebaseUser.status
    }
}
