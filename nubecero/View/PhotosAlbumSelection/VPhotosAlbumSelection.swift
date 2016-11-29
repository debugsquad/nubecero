import UIKit

class VPhotosAlbumSelection:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotosAlbumSelection!
    private weak var collectionView:UICollectionView!
    private weak var layoutButtonCancelLeft:NSLayoutConstraint!
    private let kSelectAfter:TimeInterval = 0.1
    private let kButtonCancelWidth:CGFloat = 120
    private let kCellHeight:CGFloat = 50
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CPhotosAlbumSelection)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isUserInteractionEnabled = false
        visualEffect.clipsToBounds = true
        
        let vibrancyEffect:UIVibrancyEffect = UIVibrancyEffect(blurEffect:blurEffect)
        let vibrancyVisual:UIVisualEffectView = UIVisualEffectView(effect:vibrancyEffect)
        vibrancyVisual.translatesAutoresizingMaskIntoConstraints = false
        vibrancyVisual.isUserInteractionEnabled = false
        vibrancyVisual.clipsToBounds = true
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:22)
        labelTitle.textColor = UIColor.black
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.text = NSLocalizedString("VPhotosAlbumSelection_labelTitle", comment:"")
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPhotosAlbumSelectionCell.self,
            forCellWithReuseIdentifier:
            VPhotosAlbumSelectionCell.reusableIdentifier)
        self.collectionView = collectionView
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.3),
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("VPhotosAlbumSelection_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.regular(size:16)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        vibrancyVisual.contentView.addSubview(labelTitle)
        visualEffect.contentView.addSubview(vibrancyVisual)
        addSubview(visualEffect)
        addSubview(buttonCancel)
        addSubview(collectionView)

        let views:[String:UIView] = [
            "buttonCancel":buttonCancel,
            "visualEffect":visualEffect,
            "vibrancyVisual":vibrancyVisual,
            "labelTitle":labelTitle,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "buttonCancelWidth":kButtonCancelWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCancel(buttonCancelWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[vibrancyVisual]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[buttonCancel(45)]-45-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[vibrancyVisual]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-50-[labelTitle(30)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-95-[collectionView]-95-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonCancelLeft = NSLayoutConstraint(
            item:buttonCancel,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonCancelLeft)
        
        var indexSelected:Int = 0
        
        if let userAlbum:MPhotosItemUser = controller.currentAlbum as? MPhotosItemUser
        {
            let albumId:MPhotos.AlbumId = userAlbum.albumId
            let countAlbums:Int = MPhotos.sharedInstance.albumReferences.count
            
            for indexAlbum:Int in 0 ..< countAlbums
            {
                let reference:MPhotosItemReference = MPhotos.sharedInstance.albumReferences[
                    indexAlbum]
                
                if reference.albumId == albumId
                {
                    indexSelected = indexAlbum + 1
                    
                    break
                }
            }
        }
        
        let indexPath:IndexPath = IndexPath(item:indexSelected, section:0)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kSelectAfter)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:indexPath,
                animated:false,
                scrollPosition:
                UICollectionViewScrollPosition.centeredVertically)
        }
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonCancelWidth
        let margin:CGFloat = remain / 2.0
        
        layoutButtonCancelLeft.constant = margin
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPhotosItem
    {
        let indexItem:Int = index.item
        let item:MPhotosItem
        
        if indexItem == 0
        {
            item = MPhotos.sharedInstance.defaultAlbum
        }
        else
        {
            let reference:MPhotosItemReference = MPhotos.sharedInstance.albumReferences[indexItem - 1]
            item = MPhotos.sharedInstance.albumItems[reference.albumId]!
        }
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = MPhotos.sharedInstance.albumReferences.count + 1
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPhotosItem = modelAtIndex(index:indexPath)
        let cell:VPhotosAlbumSelectionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPhotosAlbumSelectionCell.reusableIdentifier,
            for:indexPath) as! VPhotosAlbumSelectionCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MPhotosItem = modelAtIndex(index:indexPath)
        
        if item !== controller.currentAlbum
        {
            controller.selected(album:item)
        }
    }
}
