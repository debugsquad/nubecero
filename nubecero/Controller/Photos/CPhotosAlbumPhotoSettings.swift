import UIKit

class CPhotosAlbumPhotoSettings:CController
{
    private weak var viewSettings:VPhotosAlbumPhotoSettings!
    private weak var model:MPhotosItemPhoto?
    private weak var photoController:CPhotosAlbumPhoto!
    
    convenience init(
        photoController:CPhotosAlbumPhoto,
        model:MPhotosItemPhoto)
    {
        self.init()
        self.photoController = photoController
        self.model = model
    }
    
    override func loadView()
    {
        let viewSettings:VPhotosAlbumPhotoSettings = VPhotosAlbumPhotoSettings(
            controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
    
    //MARK: private
    
    private func confirmedDelete()
    {
        guard
            
            let model:MPhotosItemPhoto = model
        
        else
        {
            back()
            
            return
        }
        
        parentController.pop
        { [weak photoController] in
            
            photoController?.deletePhoto(photo:model)
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(completion:nil)
    }
    
    func deletePhoto()
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CPhotosAlbumPhotoSettings_deleteTitle", comment:""),
            message:
            NSLocalizedString("CPhotosAlbumPhotoSettings_deleteMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbumPhotoSettings_deleteCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbumPhotoSettings_deleteDo", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { (action:UIAlertAction) in
            
            confirmedDelete()
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
