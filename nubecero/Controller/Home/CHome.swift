import UIKit

class CHome:CController
{
    private weak var viewHome:VHome!
    let model:MHome
    let askAuth:Bool
    var diskUsed:Int?
    
    init(askAuth:Bool)
    {
        model = MHome()
        self.askAuth = askAuth
        
        super.init()
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if askAuth
        {
            guard
            
                let shouldAuth:Bool = MSession.sharedInstance.settings.current?.security
            
            else
            {
                return
            }
            
            if shouldAuth
            {
                parentController.presentAuth()
                parentController.controllerAuth?.askAuth()
            }
        }
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
        
            guard
                
                let welf:CHome = self
            
            else
            {
                return
            }
            
            NotificationCenter.default.removeObserver(welf)
            NotificationCenter.default.addObserver(
                welf,
                selector:#selector(welf.notifiedSessionLoaded(sender:)),
                name:Notification.sessionLoaded,
                object:nil)
            
            MSession.sharedInstance.user.sendUpdate()
        }
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        loadUsedDisk()
    }
    
    //MARK: private
    
    private func loadUsedDisk()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let userId:MSession.UserId = MSession.sharedInstance.user.userId
            
            else
            {
                return
            }
            
            let parentUser:String = FDatabase.Parent.user.rawValue
            let propertyDiskUsed:String = FDatabaseModelUser.Property.diskUsed.rawValue
            let pathDiskUsed:String = "\(parentUser)/\(userId)/\(propertyDiskUsed)"
            
            FMain.sharedInstance.database.listenOnce(
                path:pathDiskUsed,
                modelType:FDatabaseModelUserDiskUsed.self)
            { [weak self] (diskUsed) in
                
                guard
                
                    let firebaseDiskUsed:FDatabaseModelUserDiskUsed = diskUsed
                
                else
                {
                    return
                }
                
                self?.diskUsed = firebaseDiskUsed.diskUsed
                
                DispatchQueue.main.async
                { [weak self] in
                        
                    self?.viewHome.sessionLoaded()
                }
            }
        }
    }
    
    //MARK: public
    
    func uploadPictures()
    {
        let controllerUpload:CHomeUpload = CHomeUpload()
        parentController.push(controller:controllerUpload)
    }
}
