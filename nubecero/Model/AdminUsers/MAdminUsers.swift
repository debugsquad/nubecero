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
        var allKeys:[MSession.UserId] = Array(userList.items.keys)
        
        allKeys.sort
        { (referenceA, referenceB) -> Bool in
            
            let itemA:FDatabaseModelUser = userList.items[referenceA]!
            let itemB:FDatabaseModelUser = userList.items[referenceB]!
            let before:Bool

            if ascending
            {
                before = itemA.created < itemB.created
            }
            else
            {
                before = itemB.created < itemA.created
            }
            
            return before
        }
    }
}
