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
    
    //MARK: private
    
    private func confirmDeleteAll()
    {
        model.removeAll()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewAlbum.hideLoading()
        }
    }
    
    private func confirmDeleteAlbum()
    {
        guard
            
            let userId:MSession.UserId = MSession.sharedInstance.user.userId,
            let albumUser:MPhotosItemUser = model as? MPhotosItemUser
        
        else
        {
            return
        }
        
        model.moveAll()
        
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyAlbums:String = FDatabaseModelUser.Property.albums.rawValue
        let albumId:MPhotos.AlbumId = albumUser.albumId
        let pathAlbum:String = "\(parentUser)/\(userId)/\(propertyAlbums)/\(albumId)"
        
        FMain.sharedInstance.database.removeChild(path:pathAlbum)
        MPhotos.sharedInstance.loadPhotos()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController.pop(completion:nil)
        }
    }
    
    private func renameAlbum()
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CPhotosAlbum_renameTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.alert)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_renameCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionSave:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_renameSave", comment:""),
            style:
            UIAlertActionStyle.default)
        { [weak self] (action:UIAlertAction) in
            
            self?.viewAlbum.showLoading()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                
            }
        }
        
        alert.addAction(actionSave)
        alert.addAction(actionCancel)
        alert.addTextField
        { [weak self] (textfield:UITextField) in
            
            textfield.text = self?.model.name
            textfield.returnKeyType = UIReturnKeyType.done
            textfield.placeholder = NSLocalizedString("CPhotosAlbum_renamePlaceholder", comment:"")
            textfield.keyboardType = UIKeyboardType.alphabet
        }
        
        present(alert, animated:true, completion:nil)
    }
    
    private func deleteAlbum()
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CPhotosAlbum_deleteAlbumTitle", comment:""),
            message:
            NSLocalizedString("CPhotosAlbum_deleteAlbumMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_deleteAlbumCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_deleteAlbumDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.viewAlbum.showLoading()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.confirmDeleteAlbum()
            }
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
    
    private func deleteAllPhotos()
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CPhotosAlbum_deleteAllTitle", comment:""),
            message:
            NSLocalizedString("CPhotosAlbum_deleteAllMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_deleteAllCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_deleteAllDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.viewAlbum.showLoading()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.confirmDeleteAll()
            }
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
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
            
            self?.renameAlbum()
        }
        
        let actionDeleteAlbum:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_alertDeleteAlbum", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.deleteAlbum()
        }
        
        let actionDeleteAll:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPhotosAlbum_alertDeleteAll", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.deleteAllPhotos()
        }
        
        if let _:MPhotosItemUser = model as? MPhotosItemUser
        {
            alert.addAction(actionRename)
            alert.addAction(actionDeleteAlbum)
        }
        
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
