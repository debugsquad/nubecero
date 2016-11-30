import Foundation

class MPhotosItemUser:MPhotosItem
{
    let albumId:MPhotos.AlbumId
    private let kEmpty:String = ""
    
    init(albumId:MPhotos.AlbumId, firebaseAlbum:FDatabaseModelAlbum)
    {
        self.albumId = albumId
        let name:String = firebaseAlbum.name
        
        super.init(name:name)
    }
    
    override init(name:String)
    {
        fatalError()
    }
    
    override func moveToSelf(path:String)
    {
        FMain.sharedInstance.database.updateChild(
            path:path,
            json:albumId)
    }
    
    //MARK: public
    
    func moveAll()
    {
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId
            
        else
        {
            return
        }
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let propertyAlbumId:String = FDatabaseModelPhoto.Property.albumId.rawValue
        
        for reference:MPhotosItemPhotoReference in references
        {
            guard
                
                let photo:MPhotosItemPhoto = MPhotos.sharedInstance.photos[
                    reference.photoId]
                
            else
            {
                continue
            }
            
            let photoId:MPhotos.PhotoId = photo.photoId
            let pathAlbum:String = "\(parentUser)/\(userId)/\(propertyPhotos)/\(photoId)/\(propertyAlbumId)"
            
            FMain.sharedInstance.database.updateChild(
                path:pathAlbum,
                json:kEmpty)
        }
    }
    
    func rename(name:String)
    {
        self.name = name
        
        NotificationCenter.default.post(
            name:Notification.albumRefreshed,
            object:self)
    }
}
