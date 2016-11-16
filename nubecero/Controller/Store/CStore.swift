import UIKit
import StoreKit

class CStore:CController, SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate
{
    private weak var viewStore:VStore!
    var model:MStore?
    
    override func loadView()
    {
        let viewStore:VStore = VStore(controller:self)
        self.viewStore = viewStore
        view = viewStore
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)
        model = MStore(controller:self)
    }
    
    deinit
    {
        SKPaymentQueue.default().remove(self)
    }
    
    //MARK: public
    
    func noFirebasePurchases()
    {
        viewStore.refreshStore()
    }
    
    func checkAvailabilities(itemsSet:Set<MStore.PurchaseId>)
    {
        let request:SKProductsRequest = SKProductsRequest(productIdentifiers:itemsSet)
        request.delegate = self
        request.start()
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
    
    //MARK: storeKit delegate
    
    func request(_ request:SKRequest, didFailWithError error:Error)
    {
        model?.error = error.localizedDescription
        viewStore.refreshStore()
    }
    
    func productsRequest(_ request:SKProductsRequest, didReceive response:SKProductsResponse)
    {
        let products:[SKProduct] = response.products
        
        for product:SKProduct in products
        {
            model?.loadSkProduct(skProduct:product)
        }
        
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, updatedTransactions transactions:[SKPaymentTransaction])
    {
        model?.updateTransactions(transactions:transactions)
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, removedTransactions transactions:[SKPaymentTransaction])
    {
        model?.updateTransactions(transactions:transactions)
        viewStore.refreshStore()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue:SKPaymentQueue)
    {
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, restoreCompletedTransactionsFailedWithError error:Error)
    {
        model?.error = error.localizedDescription
        viewStore.refreshStore()
    }
}
