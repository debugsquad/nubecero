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
        
        loadRecipes()
        registerNotifications()
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
            
            MSession.sharedInstance.updateLastSession()
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
    
    private func registerNotifications()
    {
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
    
    private func loadRecipes()
    {
        
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
                
                let receiptUrl:URL = Bundle.main.appStoreReceiptURL
                
            else
            {
                return
            }
            
            print("recipe url")
            print(receiptUrl)
            let receiptData:Data?
            
            do
            {
                 try receiptData = Data(contentsOf:receiptUrl)
            }
            catch
            {
                receiptData = nil
            }
            
            guard
            
                let receiptDataStrong:Data = receiptData
            
            else
            {
                return
            }
            
            let json:Any?
            
            print("string")
            print(String(data:receiptDataStrong, encoding: String.Encoding.utf8))
            
            do
            {
                try json = JSONSerialization.jsonObject(
                    with:receiptDataStrong,
                    options:JSONSerialization.ReadingOptions.allowFragments)
            }
            catch let error as Error
            {
                print("error \(error)")
                
                json = nil
            }
            
            print("json")
            print(json)
        }
    }
    
    //MARK: public
    
    func uploadPictures()
    {
        let controllerUpload:CHomeUpload = CHomeUpload()
        parentController.push(controller:controllerUpload)
    }
}
