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
    
    //MARK: public
    
    func add()
    {
        
    }
    
    func save()
    {
        
    }
}
