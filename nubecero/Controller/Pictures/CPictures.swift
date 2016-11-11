import UIKit
import FirebaseDatabase

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
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.deletablePictures()
            }
        }
    }
    
    //MARK: private
    
    private func deletablePictures()
    {
        guard
        
            let firebasePicture:FDatabaseModelPicture = mpich
    }
    
    private func confirmedDeletePicture()
    {
        guard
            
            let userId:String = MSession.sharedInstance.userId,
            let pictureId:MPictures.PictureId = viewPictures.currentItem?.pictureId,
            let dataLength:Int = viewPictures.currentItem?.size
        
        else
        {
            return
        }
        
        let parentUser:String = FStorage.Parent.user.rawValue
        let imagePath:String = "\(parentUser)/\(userId)/\(pictureId)"
        
        FMain.sharedInstance.storage.deleteData(
            path:imagePath)
        { [weak self] (error) in
            
            guard
            
                let errorString:String = error?.localizedDescription
            
            else
            {
                self?.deleteCompleted(
                    userId:userId,
                    pictureId:pictureId,
                    dataLength:dataLength)
                
                return
            }
            
            VAlert.message(message:errorString)
        }
    }
    
    private func deleteCompleted(userId:String, pictureId:MPictures.PictureId, dataLength:Int)
    {
        let parentUser:String = FDatabase.Parent.user.rawValue
        let propertyPictures:String = FDatabaseModelUser.Property.pictures.rawValue
        let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
        let pathPicture:String = "\(parentUser)/\(userId)/\(propertyPictures)/\(pictureId)"
        let pathDiskUsed:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
        
        FMain.sharedInstance.database.transaction(
            path:pathDiskUsed)
        { (mutableData:FIRMutableData) -> (FIRTransactionResult) in
            
            if let currentDiskUsed:Int = mutableData.value as? Int
            {
                var newDataLength:Int = currentDiskUsed - dataLength
                
                if newDataLength < 0
                {
                    newDataLength = 0
                }
                
                mutableData.value = newDataLength
            }
            else
            {
                mutableData.value = 0
            }
            
            let transactionResult:FIRTransactionResult = FIRTransactionResult.success(withValue:mutableData)
            
            return transactionResult
        }
        
        FMain.sharedInstance.database.removeChild(path:pathPicture)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPictures.removeSelected()
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
        parentController.over(
            controller:controllerData,
            pop:false,
            animate:true)
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
        guard
            
            let _:MPicturesItem = viewPictures.currentItem
            
        else
        {
            return
        }
        
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
