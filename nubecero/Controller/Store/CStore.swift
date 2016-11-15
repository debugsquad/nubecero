import UIKit
import StoreKit

class CStore:CController, SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate
{
    private weak var viewStore:VStore!
    
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
        MStore.sharedInstance.checkAvailability()
    }
    
    //MARK: storeKit delegate
    
    func request(_ request:SKRequest, didFailWithError error:Error)
    {
        self.error = error.localizedDescription
        notifyStore()
    }
    
    func productsRequest(_ request:SKProductsRequest, didReceive response:SKProductsResponse)
    {
        let products:[SKProduct] = response.products
        
        for product:SKProduct in products
        {
            purchase.loadSkProduct(skProduct:product)
        }
        
        notifyStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, updatedTransactions transactions:[SKPaymentTransaction])
    {
        purchase.updateTransactions(transactions:transactions)
        notifyStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, removedTransactions transactions:[SKPaymentTransaction])
    {
        purchase.updateTransactions(transactions:transactions)
        notifyStore()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue:SKPaymentQueue)
    {
        notifyStore()
    }
    
    func paymentQueue(_ queue:SKPaymentQueue, restoreCompletedTransactionsFailedWithError error:Error)
    {
        self.error = error.localizedDescription
        notifyStore()
    }
}
