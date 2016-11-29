import UIKit

class CHomeUploadSync:CController
{
    var currentItem:Int
    let uploadItems:[MHomeUploadItem]
    weak var album:MPhotosItem?
    private weak var viewSync:VHomeUploadSync!
    private weak var controllerUpload:CHomeUpload!
    private var syncStarted:Bool
    
    init(album:MPhotosItem?, uploadItems:[MHomeUploadItem], controllerUpload:CHomeUpload)
    {
        currentItem = 0
        syncStarted = false
        self.album = album
        self.uploadItems = uploadItems
        self.controllerUpload = controllerUpload
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let uploadTotal:Int = uploadItems.count
        FMain.sharedInstance.analytics?.photoUpload(photos:uploadTotal)
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
    
    private func dismissClear()
    {
        parentController.dismiss
        { [weak controllerUpload] in
            
            controllerUpload?.uploadFinished()
        }
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
        FMain.sharedInstance.analytics?.photoStopUpload()
        dismissClear()
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
            
            self?.dismissClear()
        }
    }
    
    func diskFull()
    {
        let message:String = NSLocalizedString("CHomeUploadSync_diskFull", comment:"")
        VAlert.message(message:message)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.dismissClear()
        }
    }
}
