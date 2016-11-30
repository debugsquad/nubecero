import UIKit

class VHomeCellSpacePhotos:VHomeCellSpace
{
    override init(frame:CGRect)
    {
        let color:UIColor = UIColor.black
        
        super.init(frame:frame, color:color)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedPhotosLoaded(sender:)),
            name:Notification.photosLoaded,
            object:nil)
    }
    
    override init(frame:CGRect, color:UIColor)
    {
        fatalError()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func config(controller:CHome, model:MHomeItem)
    {
        print()
    }
    
    //MARK: notified
    
    func notifiedPhotosLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.print()
        }
    }
    
    //MARK: private
    
    private func print()
    {
        let arrayPhotosIds:[MPhotos.PhotoId] = Array(MPhotos.sharedInstance.photos.keys)
        let totalPhotosInt:Int = arrayPhotosIds.count
        
        if totalPhotosInt > 0
        {
            let totalPhotos:NSNumber = totalPhotosInt as NSNumber
            
            guard
                
                let totalPhotosString:String = numberFormatter.string(from:totalPhotos)
                
            else
            {
                label.text = kEmpty
                
                return
            }
            
            let compountString:String = String(
                format:NSLocalizedString("VHomeCellSpacePhotos_label", comment:""),
                totalPhotosString)
            label.text = compountString
        }
        else
        {
            label.text = kEmpty
        }
    }
}
