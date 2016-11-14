import UIKit

class MAdminUsersPhotosItemStatusLoading:MAdminUsersPhotosItemStatus
{
    override init(model:MAdminUsersPhotosItem)
    {
        super.init(model:model)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.getImage()
        }
    }
    
    override func loadImage() -> UIImage?
    {
        return nil
    }
    
    //MARK: private
    
    private func getImage()
    {
        guard
        
            let userId:MSession.UserId = model?.userId,
            let pictureId:MPictures.PictureId = model?.pictureId
        
        else
        {
            let unknownError:String = NSLocalizedString(
                "MAdminUsersPhotosItemStatusLoading_errorUnknown",
                comment:"")
            
            model?.modeError(error:unknownError)
            
            return
        }
        
        let parentUser:String = FStorage.Parent.user.rawValue
        let pathImage:String = "\(parentUser)/\(userId)/\(pictureId)"
        
        FMain.sharedInstance.storage.loadData(
            path:pathImage)
        { [weak self] (data, error) in
            
            guard
            
                let dataStrong:Data = data,
                let image:UIImage = UIImage(data:dataStrong)
            
            else
            {
                if let errorString:String = error?.localizedDescription
                {
                    self?.model?.modeError(error:errorString)
                }
                else
                {
                    let unknownError:String = NSLocalizedString(
                        "MAdminUsersPhotosItemStatusLoading_errorUnknown",
                        comment:"")
                    
                    self?.model?.modeError(error:unknownError)
                }
                
                return
            }
            
            self?.model?.modeLoaded(image:image)
        }
    }
}
