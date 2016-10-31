import UIKit

class CHomeUploadSync:CController
{
    weak var viewSync:VHomeUploadSync!
    let uploadItems:[MHomeUploadItem]
    
    init(uploadItems:[MHomeUploadItem])
    {
        self.uploadItems = uploadItems
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
    
    override func loadView()
    {
        let viewSync:VHomeUploadSync = VHomeUploadSync(controller:self)
        self.viewSync = viewSync
        view = viewSync
    }
    
    //MARK: public
    
    func cancelSync()
    {
        parentController.dismiss()
    }
}
