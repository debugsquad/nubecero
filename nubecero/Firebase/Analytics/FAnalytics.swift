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
    private let kEventSession:NSString = "Session"
    private let kEventSessionLogout:NSString = "Logout"
    
    //MARK: public
    
    func screen(controller:CController)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventScreen,
                kFIRParameterItemID:controller.name
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    //MARK: session
    
    func logout()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventSession,
                kFIRParameterItemID:self.kEventSessionLogout
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    //MARK: actions
    
    func rate()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventAction,
                kFIRParameterItemID:self.kEventActionRate
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    func share()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventAction,
                kFIRParameterItemID:self.kEventActionShare
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    //MARK: pictures
    
    func upload(pictures:Int)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventPicture,
                kFIRParameterItemID:pictures as NSObject
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    func pictureShare()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventPicture,
                kFIRParameterItemID:self.kEventPictureShare
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    func pictureDelete()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventPicture,
                kFIRParameterItemID:self.kEventPictureDelete
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
    
    func pictureInfo()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let parameters:[String:NSObject] = [
                kFIRParameterContentType:self.kEventPicture,
                kFIRParameterItemID:self.kEventPictureInfo
            ]
            
            FIRAnalytics.logEvent(
                withName:kFIREventSelectContent,
                parameters:parameters)
        }
    }
}
