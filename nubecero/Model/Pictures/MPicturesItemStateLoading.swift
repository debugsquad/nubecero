import UIKit

class MPicturesItemStateLoading:MPicturesItemState
{
    override func preparations()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.item?.loadImageData()
        }
    }
}
