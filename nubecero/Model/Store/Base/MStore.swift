import Foundation
import StoreKit

class MStore
{
    typealias PurchaseId = String
    
    let mapItems:[PurchaseId:MStoreItem]
    private(set) var listReferences:[PurchaseId]
    private(set) var error:String?
    private weak var controller:CStore!
    private let priceFormatter:NumberFormatter
    
    init(controller:CStore)
    {
        self.controller = controller
        priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = NumberFormatter.Style.currencyISOCode
        listReferences = []
        
        let itemAlbums:MStoreItemAlbums = MStoreItemAlbums()
        
        mapItems = [
            itemAlbums.purchaseId:itemAlbums
        ]
    }
    
    //MARK: public
    
    func loadSkProduct(skProduct:SKProduct)
    {
        let productId:String = skProduct.productIdentifier
        
        guard
            
            let mappedItem:MStoreItem = mapItems?[productId]
            
        else
        {
            return
        }
        
        mappedItem.skProduct = skProduct
        priceFormatter.locale = skProduct.priceLocale
        
        let priceNumber:NSDecimalNumber = skProduct.price
        let priceString:String? = priceFormatter.string(from:priceNumber)
        mappedItem.price = priceString
    }
    
    func updateTransactions(transactions:[SKPaymentTransaction])
    {
        for skPaymentTransaction:SKPaymentTransaction in transactions
        {
            let productId:String = skPaymentTransaction.payment.productIdentifier
            
            guard
                
                let mappedItem:MStoreItem = mapItems?[productId]
                
            else
            {
                continue
            }
            
            switch skPaymentTransaction.transactionState
            {
                case SKPaymentTransactionState.deferred:
                    
                    mappedItem.statusDeferred()
                    
                    break
                    
                case SKPaymentTransactionState.failed:
                    
                    mappedItem.statusNew()
                    SKPaymentQueue.default().finishTransaction(skPaymentTransaction)
                    
                    break
                    
                case SKPaymentTransactionState.purchased,
                     SKPaymentTransactionState.restored:
                    
                    mappedItem.statusPurchased()
                    SKPaymentQueue.default().finishTransaction(skPaymentTransaction)
                    
                    break
                    
                case SKPaymentTransactionState.purchasing:
                    
                    mappedItem.statusPurchasing()
                    
                    break
            }
        }
    }
}
