import UIKit

class MPhotosItemPhotoStateLoading:MPhotosItemPhotoState
{
    override func preparations()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.item?.loadImageData()
        }
    }
}
