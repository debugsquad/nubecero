import UIKit

class CPicturesData:CController
{
    weak var model:MPicturesItem!
    weak var viewData:VPicturesData!
    
    init(model:MPicturesItem)
    {
        self.model = model
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewData:VPicturesData = VPicturesData(controller:self)
        self.viewData = viewData
        view = viewData
    }
}
