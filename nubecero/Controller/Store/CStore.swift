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
        model = MStore()
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
            purchase.loadSkProduct(skProduct:product)
        }
        
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, updatedTransactions transactions:[SKPaymentTransaction])
    {
        purchase.updateTransactions(transactions:transactions)
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, removedTransactions transactions:[SKPaymentTransaction])
    {
        purchase.updateTransactions(transactions:transactions)
        viewStore.refreshStore()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue:SKPaymentQueue)
    {
        viewStore.refreshStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, restoreCompletedTransactionsFailedWithError error:Error)
    {
        self.error = error.localizedDescription
        viewStore.refreshStore()
    }
}
