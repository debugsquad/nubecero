import UIKit
import UserNotifications

class CHome:CController
{
    private weak var viewHome:VHome!
    let model:MHome
    let askAuth:Bool
    var diskUsed:Int?
    private let kAskNotifications:TimeInterval = 3
    
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
            
                let shouldAuth:Bool = MSession.sharedInstance.settings?.security
            
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
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAskNotifications)
        {
            if #available(iOS 10.0, *)
            {
                let authOptions:UNAuthorizationOptions = [
                    UNAuthorizationOptions.alert,
                    UNAuthorizationOptions.badge,
                    UNAuthorizationOptions.sound]
                
                UNUserNotificationCenter.current().requestAuthorization(options:authOptions)
                { (_, _) in
                }
            }
            else
            {
                let settings:UIUserNotificationSettings = UIUserNotificationSettings(
                    types:[
                        UIUserNotificationType.alert,
                        UIUserNotificationType.badge,
                        UIUserNotificationType.sound],
                    categories:nil)
                
                UIApplication.shared.registerUserNotificationSettings(settings)
            }
            
            UIApplication.shared.registerForRemoteNotifications()
        }
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
    }
    
    //MARK: private
    
    private func loadUsedDisk()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let userId:MSession.UserId = MSession.sharedInstance.userId
            
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
