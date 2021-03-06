import UIKit

class CPhotosAlbumPhotoSettings:CController, CPhotosAlbumSelectionDelegate
{
    let model:MPhotosAlbumPhotoSettings
    weak var photo:MPhotosItemPhoto?
    weak var photoController:CPhotosAlbumPhoto!
    private weak var viewSettings:VPhotosAlbumPhotoSettings!
    
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
    
    func changeAlbum()
    {
        let album:MPhotosItem? = photoController.albumController.model
        
        let albumSelection:CPhotosAlbumSelection = CPhotosAlbumSelection(
            currentAlbum:album,
            delegate:self)
        parentController.over(
            controller:albumSelection,
            pop:false,
            animate:true)
    }
    
    //MARK: albumSelection delegate
    
    func albumSelected(album:MPhotosItem)
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
            
            photoController?.moveToAlbum(
                photo:photo,
                album:album)
        }
    }
}
