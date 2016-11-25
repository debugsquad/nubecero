import UIKit

class CPhotosAlbumPhoto:CController
{
    weak var viewPhoto:VPhotosAlbumPhoto!
    var selected:Int
    let model:MPhotosItem
    let inRect:CGRect
    
    init(model:MPhotosItem, selected:Int, inRect:CGRect)
    {
        self.model = model
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
    
    func back()
    {
        parentController.dismiss()
    }
    
    func share()
    {
        let reference:MPhotosItemPhotoReference = model.references[selected]
        let photo:MPhotosItemPhoto? = MPhotos.sharedInstance.photos[
            reference.photoId]
        
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
        
    }
}
