import UIKit

class VHomeCellPictures:VHomeCell
{
    private weak var label:UILabel!
    private let numberFormatter:NumberFormatter
    private let kEmpty:String = ""
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        super.init(frame:frame)
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
    
    override func config(controller:CHome, model:MHomeItem)
    {/*
        let totalPicturesInt:Int = MPictures.sharedInstance.references.count
        
        if totalPicturesInt > 0
        {
            let totalPictures:NSNumber = totalPicturesInt as NSNumber
            
            guard
                
                let totalPicturesString:String = numberFormatter.string(from:totalPictures)
                
            else
            {
                label.text = kEmpty
                
                return
            }
            
            let compountString:String = String(
                format:NSLocalizedString("VHomeCellPictures_label", comment:""),
                totalPicturesString)
            label.text = compountString
        }
        else
        {
            label.text = kEmpty
        }*/
    }
}
