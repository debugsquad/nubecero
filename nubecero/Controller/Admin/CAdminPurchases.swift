import UIKit

class CAdminPurchases:CController
{
    private weak var viewPurchases:VAdminPurchases!
    var model:MAdminPurchases?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = NSLocalizedString("CAdminPurchases_title", comment:"")
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadPurchases()
        }
    }
    
    override func loadView()
    {
        let viewPurchases:VAdminPurchases = VAdminPurchases(controller:self)
        self.viewPurchases = viewPurchases
        view = viewPurchases
    }
    
    //MARK: private
    
    private func loadPurchases()
    {
        let pathPurchases:String = FDatabase.Parent.purchase.rawValue
        
        FMain.sharedInstance.database.listenOnce(
            path:pathPurchases,
            modelType:FDatabaseModelPurchaseList.self)
        { [weak self] (purchaseList) in
            
            guard
            
                let purchaseListStrong:FDatabaseModelPurchaseList = purchaseList
            
            else
            {
                let error:String = NSLocalizedString("CAdminPurchases_errorLoading", comment:"")
                self?.loadingError(error:error)
                
                return
            }
            
            self?.model = MAdminPurchases(purchaseList:purchaseListStrong)
            self?.loadingCompleted()
        }
    }
    
    private func loadingError(error:String)
    {
        VAlert.message(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPurchases.errorLoading()
        }
    }
    
    private func loadingCompleted()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPurchases.completedLoading()
        }
    }
    
    private func confirmSave()
    {
        
    }
    
    //MARK: public
    
    func add()
    {
        
    }
    
    func save()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CAdminPurchases_alertTitle", comment:""),
            message:
            NSLocalizedString("CAdminPurchases_alertMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CAdminPurchases_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionSave:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CAdminPurchases_alertSave", comment:""),
            style:
            UIAlertActionStyle.default)
        { (action) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.confirmSave()
            }
        }
        
        alert.addAction(actionSave)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
