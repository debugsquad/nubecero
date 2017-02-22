import Foundation

class MAdminUsersItem
{
    let userId:MSession.UserId
    let userEmail:String
    let created:TimeInterval
    let lastSession:TimeInterval
    let diskUsed:Int
    let status:MSession.Status
    
    init(userId:MSession.UserId, firebaseUser:FDatabaseModelUser)
    {
        self.userId = userId
        userEmail = firebaseUser.email
        created = firebaseUser.created
        lastSession = firebaseUser.session.timestamp
        diskUsed = firebaseUser.diskUsed
        status = firebaseUser.session.status
    }
}
