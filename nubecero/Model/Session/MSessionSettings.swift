import Foundation

class MSessionSettings
{
    var current:DObjectSettings?
    
    //MARK: private
    
    private func asyncLoadSettings()
    {
        DManager.sharedInstance.fetchManagedObjects(
            modelType:DObjectSettings.self,
            limit:1)
        { (objects:[DObjectSettings]?) in
            
            guard
                
                let settings:DObjectSettings = objects?.first
                
            else
            {
                self.createSettings()
                
                return
            }
            
            self.current = settings
            self.settingsLoaded()
        }
    }
    
    private func settingsLoaded()
    {
        NotificationCenter.default.post(
            name:Notification.settingsLoaded,
            object:nil)
    }
    
    private func createSettings()
    {
        DManager.sharedInstance.createManagedObject(
            modelType:DObjectSettings.self)
        { (settings:DObjectSettings) in
            
            self.current = settings
            
            DManager.sharedInstance.save()
            self.settingsLoaded()
        }
    }
    
    //MARK: public
    
    func loadSettings()
    {
        if current == nil
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.asyncLoadSettings()
            }
        }
    }
}
