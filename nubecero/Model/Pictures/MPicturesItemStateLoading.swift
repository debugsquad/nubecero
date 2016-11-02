import UIKit

class MPicturesItemStateLoading:MPicturesItemState
{
    override func preparations()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
            
                let pictureId:MPictures.PictureId = self?.item?.pictureId,
                let userId:String = MSession.sharedInstance.userId
            
            else
            {
                return
            }
            
            let parentUser:String = FStorage.Parent.user.rawValue
            let imagePath:String = "\(parentUser)/\(userId)/\(pictureId)"
            
            FMain.sharedInstance.storage.loadData(
                path:imagePath)
            { [weak self] (data) in
            
                guard
                
                    let dataStrong:Data = data
                
                else
                {
                    self?.item?.stateClear()
                    
                    return
                }
                
                guard
                    
                    let image:UIImage = UIImage(data:dataStrong)
                
                else
                {
                    self?.item?.stateClear()
                    
                    return
                }
                
                self?.item?.generateThumbnail(image:image)
            }
        }
    }
}
