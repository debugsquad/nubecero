import UIKit

class CPicturesData:CController
{
    weak var model:MPicturesItem!
    weak var viewData:VPicturesData!
    
    init(model:MPicturesItem)
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
        let viewData:VPicturesData = VPicturesData(controller:self)
        self.viewData = viewData
        view = viewData
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.statusBarDefault()
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.statusBarLight()
    }
}
