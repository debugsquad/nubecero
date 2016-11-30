import UIKit

class VHomeCellPhotos:VHomeCell
{
    private weak var label:UILabel!
    private let numberFormatter:NumberFormatter
    private let kEmpty:String = ""
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        super.init(frame:frame)
        backgroundColor = UIColor(white:0, alpha:0.05)
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:13)
        label.textColor = UIColor.black
        self.label = label
        
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
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
                format:NSLocalizedString("VHomeCellPhotos_label", comment:""),
                totalPhotosString)
            label.text = compountString
        }
        else
        {
            label.text = kEmpty
        }
    }
}
