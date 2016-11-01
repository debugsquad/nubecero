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
                    self?.returnToNone()
                    
                    return
                }
                
                
                guard
                    
                    let image:UIImage = UIImage(data:dataStrong)
                
                else
                {
                    self?.returnToNone()
                    
                    return
                }
                
                self?.loadingCompleted(image:image)
            }
        }
    }
    
    //MARK: private
    
    private func returnToNone()
    {
        item?.state = MPicturesItemStateNone(item:item)
    }
    
    private func loadingCompleted(image:UIImage)
    {
        item?.image = image
        item?.thumbnail = image
        item?.state = MPicturesItemStateLoaded(item:item)
    }
}
