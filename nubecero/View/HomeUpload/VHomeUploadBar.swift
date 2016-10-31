import UIKit

class VHomeUploadBar:UIView
{
    private weak var controller:CHomeUpload!
    private weak var commitButton:UIButton!
    private weak var amountLabel:UILabel!
    private let kCommitButtonWidth:CGFloat = 100
    private let kCommitButtonInsetsRight:CGFloat = 50
    private let kAmountLabelRight:CGFloat = -64
    private let kAmountLabelWidth:CGFloat = 100
    private let kAlphaEmpty:CGFloat = 0.3
    private let kEmpty:String = ""
    
    convenience init(controller:CHomeUpload)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let commitButton:UIButton = UIButton()
        commitButton.translatesAutoresizingMaskIntoConstraints = false
        commitButton.clipsToBounds = true
        commitButton.tintColor = UIColor.black
        commitButton.setImage(
            #imageLiteral(resourceName: "assetHomeUploadCommit").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        commitButton.setImage(
            #imageLiteral(resourceName: "assetHomeUploadCommit").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        commitButton.imageView!.clipsToBounds = true
        commitButton.imageView!.contentMode = UIViewContentMode.center
        commitButton.imageEdgeInsets = UIEdgeInsets(top:0, left:kCommitButtonInsetsRight, bottom:0, right:0)
        commitButton.addTarget(
            self,
            action:#selector(actionCommit(sender:)),
            for:UIControlEvents.touchUpInside)
        self.commitButton = commitButton
        
        let amountLabel:UILabel = UILabel()
        amountLabel.isUserInteractionEnabled = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.backgroundColor = UIColor.clear
        amountLabel.font = UIFont.regular(size:16)
        amountLabel.textColor = UIColor.white
        amountLabel.textAlignment = NSTextAlignment.right
        self.amountLabel = amountLabel
        
        addSubview(amountLabel)
        addSubview(commitButton)
        
        let views:[String:UIView] = [
            "commitButton":commitButton,
            "amountLabel":amountLabel]
        
        let metrics:[String:CGFloat] = [
            "commitButtonWidth":kCommitButtonWidth,
            "amountLabelRight":kAmountLabelRight,
            "amountLabelWidth":kAmountLabelWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[amountLabel(amountLabelWidth)]-(amountLabelRight)-[commitButton(commitButtonWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[commitButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-24-[amountLabel]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        config(amount:0)
    }
    
    //MARK: actions
    
    func actionCommit(sender button:UIButton)
    {
        guard
            
            let selectedItems:[IndexPath] = controller.viewUpload.collectionView.indexPathsForSelectedItems
        
        else
        {
            return
        }
        
        var uploadItems:[MHomeUploadItem] = []
        
        for indexSelected:IndexPath in selectedItems
        {
            let itemIndex:Int = indexSelected.item
            let uploadItem:MHomeUploadItem = controller.model.items[itemIndex]
            uploadItems.append(uploadItem)
        }
        
        controller.commitUpload()
    }
    
    //MARK: public
    
    func config(amount:Int)
    {
        if amount > 0
        {
            commitButton.isUserInteractionEnabled = true
            commitButton.alpha = 1
            amountLabel.text = "\(amount)"
        }
        else
        {
            commitButton.isUserInteractionEnabled = false
            commitButton.alpha = kAlphaEmpty
            amountLabel.text = kEmpty
        }
    }
}
