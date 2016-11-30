import UIKit

class CStoreAd:CController
{
    private weak var viewAd:VStoreAd!
    
    override func loadView()
    {
        let viewAd:VStoreAd = VStoreAd(controller:self)
        self.viewAd = viewAd
        view = viewAd
    }
    
    //MARK: public
    
    func cancel()
    {
        parentController.dismiss(centered:true, completion:nil)
    }
    
    func accept()
    {
        p
    }
}
