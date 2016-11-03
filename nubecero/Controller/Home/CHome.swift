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
    
    override func viewDidLoad()
    {
        if let _:MSessionServer = MSession.sharedInstance.server
        {
            sessionLoaded()
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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        print("::::::::::::::::::::::::::::::::::::::::   view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("::::::::::::::::::::::::::::::::::::::::   view will disappear")
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.sessionLoaded()
        }
    }
    
    //MARK: private
    
    private func sessionLoaded()
    {
        viewHome.sessionLoaded()
    }
    
    //MARK: public
    
    func uploadPictures()
    {
        let controllerUpload:CHomeUpload = CHomeUpload()
        parentController.push(controller:controllerUpload)
    }
}
