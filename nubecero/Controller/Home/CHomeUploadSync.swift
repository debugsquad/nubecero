import UIKit

class CHomeUploadSync:CController
{
    var currentItem:Int
    let uploadItems:[MHomeUploadItem]
    private weak var viewSync:VHomeUploadSync!
    private weak var controllerUpload:CHomeUpload!
    private var syncStarted:Bool
    
    init(uploadItems:[MHomeUploadItem], controllerUpload:CHomeUpload)
    {
        currentItem = 0
        syncStarted = false
        self.uploadItems = uploadItems
        self.controllerUpload = controllerUpload
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let uploadTotal:Int = uploadItems.count
        FMain.sharedInstance.analytics?.upload(pictures:uploadTotal)
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        parentController.statusBarDefault()
        
        if !syncStarted
        {
            syncStarted = true
            keepSyncing()
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
        let uploadItem:MHomeUploadItem = uploadItems[currentItem]
        uploadItem.status.process(controller:self)
    }
    
    //MARK: public
    
    func uploadedItems() -> Int
    {
        var uploaded:Int = 0
     
        for uploadedItem:MHomeUploadItem in uploadItems
        {
            if uploadedItem.status.finished
            {
                uploaded += 1
            }
        }
        
        return uploaded
    }
    
    func cancelSync()
    {
        parentController.dismiss()
    }
    
    func errorSyncing(error:String)
    {
        VAlert.message(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewSync.errorFound()
        }
    }
    
    func keepSyncing()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.nextStep()
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewSync.stepCompleted()
        }
    }
    
    func syncComplete()
    {
        let message:String = NSLocalizedString("CHomeUploadSync_syncComplete", comment:"")
        VAlert.message(message:message)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController.dismiss()
            self?.controllerUpload.picturesUploaded()
        }
    }
    
    func diskFull()
    {
        let message:String = NSLocalizedString("CHomeUploadSync_diskFull", comment:"")
        VAlert.message(message:message)
        
        DispatchQueue.main.async
        { [weak self] in
                
            self?.parentController.dismiss()
            self?.controllerUpload.picturesUploaded()
        }
    }
}
