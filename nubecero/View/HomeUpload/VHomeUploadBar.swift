import UIKit

class VHomeUploadBar:UIView
{
    private weak var controller:CHomeUpload!
    private weak var commitButton:UIButton!
    private let kCommitButtonWidth:CGFloat = 70
    
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
        commitButton.imageEdgeInsets = UIEdgeInsets(top:0, left:20, bottom:0, right:0)
        self.commitButton = commitButton
        
        addSubview(commitButton)
        
        let views:[String:UIView] = [
            "commitButton":commitButton]
        
        let metrics:[String:CGFloat] = [
            "commitButtonWidth":kCommitButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[commitButton(commitButtonWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[commitButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
