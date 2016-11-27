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
            nil,
            message:
            nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionRename:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_alertRename", comment:""),
            style:
            UIAlertActionStyle.default)
        { [weak self] (action:UIAlertAction) in
            
        }
        
        let actionDeleteAll:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_alertDeleteAll", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
        }
        
        alert.addAction(actionRename)
        alert.addAction(actionDeleteAll)
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
