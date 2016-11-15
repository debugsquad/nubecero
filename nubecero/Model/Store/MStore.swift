import Foundation
import StoreKit

class MStore
{
    typealias PurchaseId = String
    
    var mapItems:[PurchaseId:MStoreItem]?
    var error:String?
    private weak var controller:CStore!
    private let priceFormatter:NumberFormatter
    
    init(controller:CStore)
    {
        self.controller = controller
        priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = NumberFormatter.Style.currencyISOCode
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadFirebasePurchases()
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
                self?.controller.noFirebasePurchases()
                
                return
            }
            
            self?.listLoaded(purchaseList:purchaseListStrong)
        }
    }
    
    private func listLoaded(purchaseList:FDatabaseModelPurchaseList)
    {
        var mapItems:[PurchaseId:MStoreItem] = [:]
        var itemsSet:Set<PurchaseId> = Set<PurchaseId>()
        
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
        
        controller.checkAvailabilities(itemsSet:itemsSet)
    }
    
    //MARK: public
    
    func loadSkProduct(skProduct:SKProduct)
    {/*
         let productId:String = skProduct.productIdentifier
         
         guard
         
         let mappedItem:MStorePurchaseItem = mapItems[productId]
         
         else
         {
         return
         }
         
         mappedItem.skProduct = skProduct
         priceFormatter.locale = skProduct.priceLocale
         
         let priceNumber:NSDecimalNumber = skProduct.price
         let priceString:String? = priceFormatter.string(from:priceNumber)
         mappedItem.price = priceString*/
    }
    
    func updateTransactions(transactions:[SKPaymentTransaction])
    {/*
         for skPaymentTransaction:SKPaymentTransaction in transactions
         {
         let productId:String = skPaymentTransaction.payment.productIdentifier
         
         guard
         
         let mappedItem:MStorePurchaseItem = mapItems[productId]
         
         else
         {
         continue
         }
         
         switch skPaymentTransaction.transactionState
         {
         case SKPaymentTransactionState.deferred:
         
         mappedItem.status = MStorePurchaseItemStatusDeferred()
         
         break
         
         case SKPaymentTransactionState.failed:
         
         mappedItem.status = MStorePurchaseItemStatusNew()
         SKPaymentQueue.default().finishTransaction(skPaymentTransaction)
         
         break
         
         case SKPaymentTransactionState.purchased,
         SKPaymentTransactionState.restored:
         
         mappedItem.purchased()
         SKPaymentQueue.default().finishTransaction(skPaymentTransaction)
         
         break
         
         case SKPaymentTransactionState.purchasing:
         
         mappedItem.status = MStorePurchaseItemStatusPurchasing()
         
         break
         }
         }*/
    }
}
