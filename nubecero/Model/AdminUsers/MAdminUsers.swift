import Foundation

class MAdminUsers
{
    let userList:FDatabaseModelUserList
    var references:[MSession.UserId]
    private let kDefaultOrder:Bool = false
    
    init(userList:FDatabaseModelUserList)
    {
        self.userList = userList
        references = []
        
        order(ascending:kDefaultOrder)
    }
    
    //MARK: private
    
    private func order(ascending:Bool)
    {
        
    }
}
