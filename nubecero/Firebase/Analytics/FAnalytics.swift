import Foundation
import Firebase

class FAnalytics
{
    private let kEventScreen:NSString = "Screen"
    private let kEventAction:NSString = "Action"
    private let kEventActionRate:NSString = "Rate"
    private let kEventActionShare:NSString = "Share"
    private let kEventPicture:NSString = "Picture"
    private let kEventPictureShare:NSString = "Share"
    private let kEventPictureDelete:NSString = "Delete"
    private let kEventPictureInfo:NSString = "Info"
    private let kEventPictureUpload:NSString = "Picture/Upload"
    private let kEventSession:NSString = "Session"
    private let kEventSessionLogout:NSString = "Logout"
    private let kEventSessionTrySignin:NSString = "Try/Signin"
    private let kEventSessionTryRegister:NSString = "Try/Register"
    private let kEventSessionRegister:NSString = "Signin"
    private let kEventSessionSignin:NSString = "Register"
    
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
    
    //MARK: actions
    
    func rate()
    {
        trackSelectContent(contentType:kEventAction, itemId:kEventActionRate)
    }
    
    func share()
    {
        trackSelectContent(contentType:kEventAction, itemId:kEventActionShare)
    }
    
    //MARK: pictures
    
    func upload(pictures:Int)
    {
        let picturesObject:NSObject = "\(pictures)" as NSObject
        trackSelectContent(contentType:kEventPictureUpload, itemId:picturesObject)
    }
    
    func pictureShare()
    {
        trackSelectContent(contentType:kEventPicture, itemId:kEventPictureShare)
    }
    
    func pictureDelete()
    {
        trackSelectContent(contentType:kEventPicture, itemId:kEventPictureDelete)
    }
    
    func pictureInfo()
    {
        trackSelectContent(contentType:kEventPicture, itemId:kEventPictureInfo)
    }
}
