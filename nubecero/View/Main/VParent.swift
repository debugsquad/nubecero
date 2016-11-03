import UIKit

class VParent:UIView
{
    weak var bar:VBar!
    private weak var layoutBarHeight:NSLayoutConstraint!
    let kBarHeight:CGFloat = 64
    let kBarMinHeight:CGFloat = 20
    private let kAnimationDuration:TimeInterval = 0.3
    
    convenience init(parent:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.main
        
        let barDelta:CGFloat = kBarHeight - kBarMinHeight
        let bar:VBar = VBar(parent:parent, barHeight:kBarHeight, barDelta:barDelta)
        self.bar = bar
        addSubview(bar)
        
        let views:[String:UIView] = [
            "bar":bar]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBarHeight = NSLayoutConstraint(
            item:bar,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kBarHeight)
        
        addConstraint(layoutBarHeight)
    }
    
    //MARK: private
    
    private func scroll(controller:CController, currentController:CController, delta:CGFloat, completion:@escaping(() -> ()))
    {
        insertSubview(controller.view, belowSubview:bar)
        
        let views:[String:UIView] = [
            "view":controller.view]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:-delta)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:-delta)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        
        layoutIfNeeded()
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        currentController.layoutLeft.constant = delta
        currentController.layoutRight.constant = delta
        
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    //MARK: public
    
    func over(controller:CController, underBar:Bool, completion:@escaping(() -> ()))
    {
        if underBar
        {
            insertSubview(controller.view, belowSubview:bar)
        }
        else
        {
            addSubview(controller.view)
        }
        
        controller.view.alpha = 0
        
        let views:[String:UIView] = [
            "view":controller.view]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            controller.view.alpha = 1
        })
        { (done) in
            
            completion()
        }
    }
    
    func fromLeft(controller:CController, currentController:CController, completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        scroll(controller:controller, currentController:currentController, delta:width, completion:completion)
    }
    
    func fromRight(controller:CController, currentController:CController, completion:@escaping(() -> ()))
    {
        let width:CGFloat = -bounds.maxX
        scroll(controller:controller, currentController:currentController, delta:width, completion:completion)
    }
    
    func push(controller:CController, currentController:CController, completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        let width_2:CGFloat = width / 2.0
        
        insertSubview(controller.view, belowSubview:bar)
        
        let views:[String:UIView] = [
            "view":controller.view]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:width)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:width)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        
        layoutIfNeeded()
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        currentController.layoutLeft.constant = -width_2
        currentController.layoutRight.constant = -width_2
        currentController.addShadow()
        bar.push(name:controller.title)
        
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            self.layoutIfNeeded()
            currentController.shadow?.maxAlpha()
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func pop(currentController:CController, previousController:CController, popBar:Bool, completion:@escaping(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        currentController.layoutRight.constant = width
        currentController.layoutLeft.constant = width
        previousController.layoutLeft.constant = 0
        previousController.layoutRight.constant = 0
        
        if popBar
        {
            bar.pop()
        }
        
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            self.layoutIfNeeded()
            previousController.shadow?.minAlpha()
        })
        { (done:Bool) in
            
            previousController.shadow?.removeFromSuperview()
            completion()
        }
    }
    
    func dismiss(currentController:CController, completion:@escaping(() -> ()))
    {
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            currentController.view.alpha = 0
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func scrollDidScroll(scroll:UIScrollView)
    {
        var offsetY:CGFloat = kBarHeight - scroll.contentOffset.y
        
        if offsetY < kBarMinHeight
        {
            offsetY = kBarMinHeight
        }
        
        layoutBarHeight.constant = offsetY
    }
}
