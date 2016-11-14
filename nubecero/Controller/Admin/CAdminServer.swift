import UIKit

class CAdminServer:CController
{
    private weak var viewServer:VAdminServer!
    var model:MAdminServer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminServer_title", comment:"")
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadServer()
        }
    }
    
    override func loadView()
    {
        let viewServer:VAdminServer = VAdminServer(controller:self)
        self.viewServer = viewServer
        view = viewServer
    }
    
    //MARK: private
    
    private func loadServer()
    {
        let parentServer:String = FDatabase.Parent.server.rawValue
        
        FMain.sharedInstance.database.listenOnce(
            path:parentServer,
            modelType:FDatabaseModelServer.self)
        { [weak self] (modelServer) in
            
            guard
                
                let firebaseServer:FDatabaseModelServer = modelServer
                
            else
            {
                let error:String = NSLocalizedString("CAdminServer_loadingError", comment:"")
                self?.loadingError(error:error)
                
                return
            }
            
            self?.model = MAdminServer(server:firebaseServer)
            self?.loadCompleted()
        }
    }
    
    private func loadingError(error:String)
    {
        VAlert.message(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewServer.loadError()
        }
    }
    
    private func loadCompleted()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewServer.loadCompleted()
        }
    }
    
    private func confirmedSave()
    {
        let parentServer:String = FDatabase.Parent.server.rawValue
        let firebaseServer:FDatabaseModelServer = FDatabaseModelServer(
            froobSpace:kServerInitialFroobSize)
        let firebaseServerJson:Any = firebaseServer.modelJson()
        
        FMain.sharedInstance.database.updateChild(
            path:parentServer,
            json:firebaseServerJson)
        
        let doneMessage:String = NSLocalizedString("CAdminServer_alertDone", comment:"")
        VAlert.message(message:doneMessage)
    }
    
    //MARK: public
    
    func confirmSave()
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CAdminServer_alertTitle", comment:""),
            message:
            NSLocalizedString("CAdminServer_alertMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CAdminServer_alerCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionSave:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CAdminServer_alertSave", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { (action) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                    
                self?.confirmedSave()
            }
        }
        
        alert.addAction(actionSave)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
