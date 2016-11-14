import Foundation

class MAdminUsersPhotos
{
    let items:[MAdminUsersPhotosItem]
    
    init(pictureList:FDatabaseModelPictureList)
    {
        var items:[MAdminUsersPhotosItem] = []
        let arrayIds:[MPictures.PictureId] = Array(pictureList.items.keys)
        
        for pictureId:MPictures.PictureId in arrayIds
        {
            let firebasePicture:FDatabaseModelPicture = pictureList.items[pictureId]!
            let item:MAdminUsersPhotosItem = MAdminUsersPhotosItem(
                pictureId:pictureId,
                firebasePicture:firebasePicture)
            items.append(item)
        }
        
        items.sort
        { (itemA, itemB) -> Bool in
            
            return itemA.created < itemB.created
        }
        
        self.items = items
    }
}
