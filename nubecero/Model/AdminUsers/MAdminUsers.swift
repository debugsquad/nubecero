import Foundation

class MAdminUsers
{
    var items:[MAdminUsersItem]
    private let kDefaultOrder:Bool = false
    
    init(userList:FDatabaseModelUserList)
    {
        items = []
        let allKeys:[MSession.UserId] = Array(userList.items.keys)
        
        for key:MSession.UserId in allKeys
        {
            let firebaseUser:FDatabaseModelUser = userList.items[key]!
            let item:MAdminUsersItem = MAdminUsersItem(
                userId:key,
                firebaseUser:firebaseUser)
            items.append(item)
        }
        
        order(ascending:kDefaultOrder)
    }
    
    //MARK: private
    
    private func order(ascending:Bool)
    {
        var items:[MAdminUsersItem] = self.items
        
        items.sort
            { (itemA:MAdminUsersItem, itemB:MAdminUsersItem) -> Bool in
            
            let before:Bool
            
            if ascending
            {
                before = itemA.lastSession < itemB.lastSession
            }
            else
            {
                before = itemB.lastSession < itemA.lastSession
            }
            
            return before
        }
        
        self.items = items
    }
}
