import UIKit

class CHomeUploadSync:CController
{
    weak var viewSync:VHomeUploadSync!
    weak var controllerUpload:CHomeUpload!
    let uploadItems:[MHomeUploadItem]
    var currentItem:Int
    var syncStarted:Bool
    
    init(uploadItems:[MHomeUploadItem], controllerUpload:CHomeUpload)
    {
        currentItem = 0
        syncStarted = false
        self.controllerUpload = controllerUpload
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
        
        if !syncStarted
        {
            syncStarted = true
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.nextStep()
            }
        }
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
    
    //MARK: private
    
    private func nextStep()
    {
        let totalItems:Int = uploadItems.count
        
        if currentItem < totalItems
        {
            
        }
        else
        {
            
        }
        
        syncComplete()
    }
    
    private func syncComplete()
    {
        let message:String = NSLocalizedString("CHomeUploadSync_syncComplete", comment:"")
        VAlert.message(message:message)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController.dismiss()
        }
    }
    
    //MARK: public
    
    func cancelSync()
    {
        parentController.dismiss()
    }
}
