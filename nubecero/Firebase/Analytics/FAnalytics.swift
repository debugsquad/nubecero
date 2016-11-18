import Foundation
import Firebase

class FAnalytics
{
    private let kEventScreen:NSString = "Screen"
    private let kEventAction:NSString = "Action"
    private let kEventActionRate:NSString = "Rate"
    private let kEventActionShare:NSString = "Share"
    private let kEventPurchase:NSString = "Buy"
    private let kEventPurchaseBuy:NSString = "Buy"
    private let kEventPurchaseRestore:NSString = "Restore"
    private let kEventPhoto:NSString = "Photo"
    private let kEventPhotoStopUpload:NSString = "Upload/Stop"
    private let kEventPhotoShare:NSString = "Share"
    private let kEventPhotoDelete:NSString = "Delete"
    private let kEventPhotoInfo:NSString = "Info"
    private let kEventPhotoUpload:NSString = "Photo/Upload"
    private let kEventSession:NSString = "Session"
    private let kEventSessionLogout:NSString = "Logout"
    private let kEventSessionTrySignin:NSString = "Try/Signin"
    private let kEventSessionTryRegister:NSString = "Try/Register"
    private let kEventSessionRegister:NSString = "Signin"
    private let kEventSessionSignin:NSString = "Register"
    private let kEventSessionPasswordGenerate:NSString = "Password/Generate"
    private let kEventSessionPasswordReset:NSString = "Pasword/Reset"
    private let kEventClean:NSString = "Clean"
    private let kEventCleanPhotoDeletable:NSString = "Photo/Deletable"
    private let kEventCleanPhotoDeletableNoData:NSString = "Photo/Deletable/NoData"
    
    //MARK: private
    
    private func trackSelectContent(contentType:NSObject, itemId:NSObject)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:contentType,
                kFIRParameterItemID:itemId
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    //MARK: public
    
    func screen(controller:CController)
    {
        trackSelectContent(contentType:kEventScreen, itemId:controller.name)
    }
    
    //MARK: session
    
    func logout()
    {
        trackSelectContent(contentType:kEventSession, itemId:kEventSessionLogout)
    }
    
    func trySignin()
    {
        trackSelectContent(contentType:kEventSession, itemId:kEventSessionTrySignin)
    }
    
    func tryRegister()
    {
        trackSelectContent(contentType:kEventSession, itemId:kEventSessionTryRegister)
    }
    
    func signin()
    {
        trackSelectContent(contentType:kEventSession, itemId:kEventSessionSignin)
    }
    
    func register()
    {
        trackSelectContent(contentType:kEventSession, itemId:kEventSessionRegister)
    }
    
    func passwordReset()
    {
        trackSelectContent(contentType:kEventSession, itemId:kEventSessionPasswordReset)
    }
    
    func passwordGenerate()
    {
        trackSelectContent(contentType:kEventSession, itemId:kEventSessionPasswordGenerate)
    }
    
    //MARK: actions
    
    func rate()
    {
        trackSelectContent(contentType:kEventAction, itemId:kEventActionRate)
    }
    
    func share()
    {
        trackSelectContent(contentType:kEventAction, itemId:kEventActionShare)
    }
    
    //MARK: photos
    
    func photoUpload(photos:Int)
    {
        let photosObject:NSObject = "\(photos)" as NSObject
        trackSelectContent(contentType:kEventPhotoUpload, itemId:photosObject)
    }
    
    func photoStopUpload()
    {
        trackSelectContent(contentType:kEventPhoto, itemId:kEventPhotoStopUpload)
    }
    
    func photoShare()
    {
        trackSelectContent(contentType:kEventPhoto, itemId:kEventPhotoShare)
    }
    
    func photoDelete()
    {
        trackSelectContent(contentType:kEventPhoto, itemId:kEventPhotoDelete)
    }
    
    func photoInfo()
    {
        trackSelectContent(contentType:kEventPhoto, itemId:kEventPhotoInfo)
    }
    
    //MARK: clean
    
    func cleanPhotoDeletable()
    {
        trackSelectContent(contentType:kEventClean, itemId:kEventCleanPhotoDeletable)
    }
    
    func cleanPhotoDeletableNoData()
    {
        trackSelectContent(contentType:kEventClean, itemId:kEventCleanPhotoDeletableNoData)
    }
    
    //MARK: purchase
    
    func purchaseBuy()
    {
        trackSelectContent(contentType:kEventPurchase, itemId:kEventPurchaseBuy)
    }
    
    func purchaseRestore()
    {
        trackSelectContent(contentType:kEventPurchase, itemId:kEventPurchaseRestore)
    }
}
