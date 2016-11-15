import Foundation
import StoreKit

class MStore
{
    typealias PurchaseId = String
    
    var mapItems:[PurchaseId:MStoreItem]?
    var error:String?
    private var itemsSet:Set<PurchaseId>?
    private let priceFormatter:NumberFormatter
    
    
    
    let purchase:MStorePurchase
    
    init()
    {
        priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = NumberFormatter.Style.currencyISOCode
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadFirebasePurchases()
        }
    }
    
    //MARK: notifications
    
    func notifiedPurchasesLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        
        DispatchQueue.main.async
        {
            self.checkAvailability()
        }
    }
    
    //MARK: private
    
    private func loadFirebasePurchases()
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
                self?.error = NSLocalizedString("MStore_errorLoading", comment:"")
                
                return
            }
            
            self?.listLoaded(purchaseList:purchaseListStrong)
        }
    }
    
    private func listLoaded(purchaseList:FDatabaseModelPurchaseList)
    {
        var mapItems:[PurchaseId:MStoreItem] = [:]
        var itemsSet:Set<String> = Set<String>()
        
        let itemKeys:[FDatabaseModelPurchase.PurchaseId] = Array(purchaseList.items.keys)
        
        for itemKey:FDatabaseModelPurchase.PurchaseId in itemKeys
        {
            let firebasePurchase:FDatabaseModelPurchase = purchaseList.items[itemKey]!
            let item:MStoreItem = MStoreItem(
                firebasePurchase:firebasePurchase)
            mapItems[itemKey] = item
            itemsSet.insert(itemKey)
        }
        
        self.mapItems = mapItems
        self.itemsSet = itemsSet
    }
    
    
    private func notifyStore()
    {
        /*
        NotificationCenter.default.post(
            name:Notification.storeLoaded,
            object:nil)*/
    }
    
    //MARK: public
    
    func checkAvailability()
    {
        error = nil
        
        if purchase.mapItems.count > 0
        {
            let itemsSet:Set<String> = purchase.makeSet()
            let request:SKProductsRequest = SKProductsRequest(productIdentifiers:itemsSet)
            request.delegate = self
            request.start()
        }
        else
        {
            /*
            NotificationCenter.default.addObserver(
                self,
                selector:#selector(notifiedPurchasesLoaded(sender:)),
                name:Notification.purchasesLoaded,
                object:nil)*/
            
            purchase.loadDb()
        }
    }
    
    func restorePurchases()
    {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func purchase(skProduct:SKProduct?)
    {
        guard
            
            let skProduct:SKProduct = skProduct
        
        else
        {
            return
        }
        
        let skPayment:SKPayment = SKPayment(product:skProduct)
        SKPaymentQueue.default().add(skPayment)
    }
    
    
}
