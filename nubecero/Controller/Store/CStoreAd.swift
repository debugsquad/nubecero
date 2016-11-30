import UIKit

class CStoreAd:CController
{
    private weak var viewAd:VStoreAd!
    let model:MStoreAd
    
    init(model:MStoreAd)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
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
        let bar:VBar = parentController.viewParent.bar
        
        parentController.dismiss(centered:true)
        {   
            bar.openStore()
        }
    }
}
