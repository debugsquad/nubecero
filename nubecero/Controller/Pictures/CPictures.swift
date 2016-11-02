import UIKit

class CPictures:CController
{
    weak var viewPictures:VPictures!
    
    override func loadView()
    {
        let viewPictures:VPictures = VPictures(controller:self)
        self.viewPictures = viewPictures
        view = viewPictures
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedPicturesLoaded(sender:)),
            name:Notification.picturesLoaded,
            object:nil)
        
        MPictures.sharedInstance.loadPictures()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
        MPictures.sharedInstance.cleanResources()
    }
    
    //MARK: notified
    
    func notifiedPicturesLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPictures.picturesLoaded()
        }
    }
    
    private func confirmedDeletePicture()
    {
        guard
            
            let userId:String = MSession.sharedInstance.userId,
            let pictureId:MPictures.PictureId = viewPictures.currentItem?.pictureId
        
        else
        {
            return
        }
        
        let parentUser:String = FStorage.Parent.user.rawValue
        let imagePath:String = "\(parentUser)/\(userId)/\(pictureId)"
        
        FMain.sharedInstance.storage.deleteData(
            path:imagePath)
        { [weak self] (error) in
            
            
        }
    }
    
    //MARK: public
    
    func showData()
    {
        guard
        
            let picture:MPicturesItem = viewPictures.currentItem
        
        else
        {
            return
        }
        
        let controllerData:CPicturesData = CPicturesData(model:picture)
        parentController.over(controller:controllerData, pop:false)
    }
    
    func share()
    {
        guard
            
            let image:UIImage = viewPictures.currentItem?.image
        
        else
        {
            return
        }
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[image],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewPictures
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
    
    func deletePicture()
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CPictures_deleteTitle", comment:""),
            message:
            NSLocalizedString("CPictures_deleteMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPictures_deleteCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CPictures_deleteDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { (action) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.confirmedDeletePicture()
            }
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
