import UIKit

class CPhotosAlbum:CController
{
    private weak var viewAlbum:VPhotosAlbum!
    let model:MPhotosItem
    
    init(model:MPhotosItem)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewWillAppear(_ animated:Bool)
    {
        super.viewWillAppear(animated)
        parentController.statusBarDefault()
        viewAlbum.collectionView.scrollsToTop = true
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.statusBarLight()
    }
    
    override func loadView()
    {
        let viewAlbum:VPhotosAlbum = VPhotosAlbum(controller:self)
        self.viewAlbum = viewAlbum
        view = viewAlbum
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(completion:nil)
    }
    
    func options()
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
    
    func selectPhoto(item:Int, inRect:CGRect)
    {
        viewAlbum.collectionView.scrollsToTop = false
        
        let controller:CPhotosAlbumPhoto = CPhotosAlbumPhoto(
            albumController:self,
            selected:item,
            inRect:inRect)
        
        parentController.over(
            controller:controller,
            pop:false,
            animate:false)
    }
    
    func removeFromList(photo:MPhotosItemPhoto)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model.removePhoto(item:photo)
        }
    }
}
