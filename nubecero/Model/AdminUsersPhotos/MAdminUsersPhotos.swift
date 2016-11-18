import Foundation

class MAdminUsersPhotos
{
    let items:[MAdminUsersPhotosItem]
    
    init(userId:MSession.UserId, photoList:FDatabaseModelPhotoList)
    {
        var items:[MAdminUsersPhotosItem] = []
        let arrayIds:[MPhotos.PhotoId] = Array(photoList.items.keys)
        
        for photoId:MPhotos.PhotoId in arrayIds
        {
            let firebasePhoto:FDatabaseModelPhoto = photoList.items[photoId]!
            let item:MAdminUsersPhotosItem = MAdminUsersPhotosItem(
                userId:userId,
                photoId:photoId,
                firebasePhoto:firebasePhoto)
            items.append(item)
        }
        
        items.sort
        { (itemA, itemB) -> Bool in
            
            return itemA.created < itemB.created
        }
        
        self.items = items
    }
}
