import UIKit

class CPhotosAlbumPhoto:CController
{
    weak var viewPhoto:VPhotosAlbumPhoto!
    weak var albumController:CPhotosAlbum!
    var selected:Int
    let inRect:CGRect
    
    init(albumController:CPhotosAlbum, selected:Int, inRect:CGRect)
    {
        self.albumController = albumController
        self.selected = selected
        self.inRect = inRect
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.statusBarDefault()
    }
    
    override func loadView()
    {
        let viewPhoto:VPhotosAlbumPhoto = VPhotosAlbumPhoto(controller:self)
        self.viewPhoto = viewPhoto
        view = viewPhoto
    }
    
    //MARK: public
    
    func selectedPhoto() -> MPhotosItemPhoto?
    {
        let reference:MPhotosItemPhotoReference = albumController.model.references[selected]
        let photo:MPhotosItemPhoto? = MPhotos.sharedInstance.photos[
            reference.photoId]
        
        return photo
    }
    
    func back()
    {
        parentController.dismiss()
    }
    
    func share()
    {
        let photo:MPhotosItemPhoto? = selectedPhoto()
        
        guard
            
            let image:UIImage = photo?.resources.image
            
        else
        {
            return
        }
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[image],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewPhoto
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
    
    func settings()
    {
        guard
            
            let photo:MPhotosItemPhoto = selectedPhoto()
        
        else
        {
            return
        }
        
        let controllerSettings:CPhotosAlbumPhotoSettings = CPhotosAlbumPhotoSettings(
            photoController:self,
            model:photo)
        parentController.push(
            controller:controllerSettings,
            underBar:false)
    }
    
    func deletePhoto(photo:MPhotosItemPhoto)
    {
        MPhotos.sharedInstance.markForDeletion(
            item:photo)
        
        parentController.dismiss()
    }
}
