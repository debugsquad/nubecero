import UIKit

class CPhotosAlbumPhotoSettings:CController
{
    let model:MPhotosAlbumPhotoSettings
    weak var photo:MPhotosItemPhoto?
    private weak var viewSettings:VPhotosAlbumPhotoSettings!
    private weak var photoController:CPhotosAlbumPhoto!
    
    init(
        photoController:CPhotosAlbumPhoto,
        photo:MPhotosItemPhoto)
    {
        model = MPhotosAlbumPhotoSettings()
        
        super.init()
        self.photoController = photoController
        self.photo = photo
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
            
            let photo:MPhotosItemPhoto = photo
        
        else
        {
            back()
            
            return
        }
        
        parentController.pop
        { [weak photoController] in
            
            photoController?.deletePhoto(photo:photo)
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
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmedDelete()
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
