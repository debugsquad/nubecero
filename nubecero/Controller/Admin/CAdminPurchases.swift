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
        guard
            
            let json:Any = model?.savingJson()
        
        else
        {
            return
        }
        
        let pathPurchases:String = FDatabase.Parent.purchase.rawValue
        
        FMain.sharedInstance.database.updateChild(
            path:pathPurchases,
            json:json)
        
        let confirmMessage:String = NSLocalizedString("CAdminPurchases_alertDone", comment:"")
        VAlert.message(message:confirmMessage)
        
        loadPurchases()
    }
    
    private func confirmAdd()
    {
        let pathPurchases:String = FDatabase.Parent.purchase.rawValue
        let newPurchase:FDatabaseModelPurchase = FDatabaseModelPurchase()
        let jsonPurchase:Any = newPurchase.modelJson()
        
        let _:String = FMain.sharedInstance.database.createChild(
            path:pathPurchases,
            json:jsonPurchase)
        
        let confirmMessage:String = NSLocalizedString("CAdminPurchases_purchaseAdded", comment:"")
        VAlert.message(message:confirmMessage)
        
        loadPurchases()
    }
    
    private func confirmDelete(item:MAdminPurchasesItem)
    {
        let parentPurchase:String = FDatabase.Parent.purchase.rawValue
        let pathPurchase:String = "\(parentPurchase)/\(item.firebasePurchaseId)"
        FMain.sharedInstance.database.removeChild(path:pathPurchase)
        
        let confirmMessage:String = NSLocalizedString("CAdminPurchases_deleteDone", comment:"")
        VAlert.message(message:confirmMessage)
        
        loadPurchases()
    }
    
    //MARK: public
    
    func add()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.confirmAdd()
        }
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
    
    func deletePurchase(item:MAdminPurchasesItem)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CAdminPurchases_deleteTitle", comment:""),
            message:
            NSLocalizedString("CAdminPurchases_deleteMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CAdminPurchases_deleteCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CAdminPurchases_deleteDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { (action) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                    
                self?.confirmDelete(item:item)
            }
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
