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
}
