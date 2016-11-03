import UIKit

class CHome:CController
{
    weak var viewHome:VHome!
    let model:MHome
    var usedDisk:Int?
    
    init()
    {
        model = MHome()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if let _:MSessionServer = MSession.sharedInstance.server
        {
            loadUsedDisk()
        }
        else
        {
            NotificationCenter.default.addObserver(
                self,
                selector:#selector(notifiedSessionLoaded(sender:)),
                name:Notification.sessionLoaded,
                object:nil)
        }
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        loadUsedDisk()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.sessionLoaded()
        }
    }
    
    //MARK: private
    
    private func loadUsedDisk()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let userId:String = MSession.sharedInstance.userId
            
            else
            {
                return
            }
            
            let parentUser:String = FDatabase.Parent.user.rawValue
            let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
            let pathDiskUsed:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
            
            FMain.sharedInstance.database.listenOnce(
                path:pathDiskUsed,
                modelType:fdatamodel, completion: <#T##((ModelType?) -> ())##((ModelType?) -> ())##(ModelType?) -> ()#>)
        }
    }
    
    //MARK: public
    
    func uploadPictures()
    {
        let controllerUpload:CHomeUpload = CHomeUpload()
        parentController.push(controller:controllerUpload)
    }
}
