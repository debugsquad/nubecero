import Foundation
import StoreKit

class MStore
{
    typealias PurchaseId = String
    
    let mapItems:[PurchaseId:MStoreItem]
    let references:[PurchaseId]
    var error:String?
    private let priceFormatter:NumberFormatter
    
    init()
    {
        priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = NumberFormatter.Style.currencyISOCode
        
        let itemAlbums:MStoreItemAlbums = MStoreItemAlbums()
        
        mapItems = [
            itemAlbums.purchaseId:itemAlbums
        ]
        
        references = [
            itemAlbums.purchaseId
        ]
    }
    
    //MARK: public
    
    func loadSkProduct(skProduct:SKProduct)
    {
        let productId:String = skProduct.productIdentifier
        
        guard
            
            let mappedItem:MStoreItem = mapItems[productId]
            
        else
        {
            return
        }
        
        mappedItem.skProduct = skProduct
        priceFormatter.locale = skProduct.priceLocale
        
        let priceNumber:NSDecimalNumber = skProduct.price
        
        guard
            
            let priceString:String = priceFormatter.string(from:priceNumber)
        
        else
        {
            return
        }
        
        mappedItem.foundPurchase(price:priceString)
    }
    
    func updateTransactions(transactions:[SKPaymentTransaction])
    {
        for skPaymentTransaction:SKPaymentTransaction in transactions
        {
            let productId:String = skPaymentTransaction.payment.productIdentifier
            
            guard
                
                let mappedItem:MStoreItem = mapItems[productId]
                
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
