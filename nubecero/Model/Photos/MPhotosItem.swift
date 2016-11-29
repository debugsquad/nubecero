import Foundation

class MPhotosItem
{
    let name:String
    private(set) var references:[MPhotosItemPhotoReference]
    private(set) var kiloBytes:Int
    private let kEmpty:String = ""
    private let kZero:Int = 0
    
    init(name:String)
    {
        self.name = name
        references = []
        kiloBytes = kZero
    }
    
    //MARK: public
    
    func clearReferences()
    {
        kiloBytes = kZero
        references = []
    }
    
    func addReference(reference:MPhotosItemPhotoReference, kiloBytes:Int)
    {
        references.append(reference)
        self.kiloBytes += kiloBytes
    }
    
    func sortPhotos()
    {
        references.sort
        { (referenceA:MPhotosItemPhotoReference, referenceB:MPhotosItemPhotoReference) -> Bool in
            
            let createdA:TimeInterval = referenceA.created
            let createdB:TimeInterval = referenceB.created
            
            return createdA > createdB
        }
    }
    
    func removePhoto(item:MPhotosItemPhoto)
    {
        let countReferences:Int = references.count
        var index:Int? = nil
        
        for indexReference:Int in 0 ..< countReferences
        {
            let reference:MPhotosItemPhotoReference = references[indexReference]
            
            if reference.photoId == item.photoId
            {
                index = indexReference
                
                break
            }
        }
        
        guard
        
            let indexFound:Int = index
        
        else
        {
            return
        }
        
        kiloBytes -= item.size
        references.remove(at:indexFound)
        
        NotificationCenter.default.post(
            name:Notification.albumRefreshed,
            object:self)
    }
    
    func removeAll()
    {
        for reference:MPhotosItemPhotoReference in references
        {
            guard
                
                let photo:MPhotosItemPhoto = MPhotos.sharedInstance.photos[
                    reference.photoId]
                
            else
            {
                continue
            }
            
            MPhotos.sharedInstance.markForDeletion(
                item:photo)
        }
        
        kiloBytes = kZero
        references = []
        
        NotificationCenter.default.post(
            name:Notification.albumRefreshed,
            object:self)
    }
    
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
    
    func moveToSelf(path:String)
    {
        fatalError()
    }
    
    func moveToList(photo:MPhotosItemPhoto)
    {
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId
            
        else
        {
            return
        }
        
        let photoId:MPhotos.PhotoId = photo.photoId
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPhotos:String = FDatabaseModelUser.Property.photos.rawValue
        let propertyAlbumId:String = FDatabaseModelPhoto.Property.albumId.rawValue
        let pathAlbum:String = "\(parentUser)/\(userId)/\(propertyPhotos)/\(photoId)/\(propertyAlbumId)"
        
        moveToSelf(path:pathAlbum)
        
        let photoReference:MPhotosItemPhotoReference = MPhotosItemPhotoReference(
            photoId:photo.photoId,
            created:photo.created)
        
        references.insert(
            photoReference,
            at:0)
        
        NotificationCenter.default.post(
            name:Notification.albumRefreshed,
            object:self)
    }
}
