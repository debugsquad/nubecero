import UIKit

class VPhotosAlbum:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotosAlbum!
    private weak var backButton:UIButton!
    private weak var collectionView:UICollectionView!
    private weak var layoutBackgroundTop:NSLayoutConstraint!
    private weak var layoutBackButtonTop:NSLayoutConstraint!
    private weak var layoutTitleBottom:NSLayoutConstraint!
    private var cellSize:CGSize!
    private let kInterLine:CGFloat = 1
    private let kCollectionTop:CGFloat = 130
    private let kBackButtonTop:CGFloat = 20
    private let kDeselectTime:TimeInterval = 1
    
    convenience init(controller:CPhotosAlbum)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let leftBorder:UIView = UIView()
        leftBorder.isUserInteractionEnabled = false
        leftBorder.translatesAutoresizingMaskIntoConstraints = false
        leftBorder.backgroundColor = UIColor.black
        
        let background:UIView = UIView()
        background.clipsToBounds = true
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = UIColor.white
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.black
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.backButton = backButton
        
        let albumTitle:VPhotosAlbumTitle = VPhotosAlbumTitle(controller:controller)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = kInterLine
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop + kInterLine,
            left:kInterLine,
            bottom:kInterLine,
            right:kInterLine)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPhotosAlbumCell.self,
            forCellWithReuseIdentifier:
            VPhotosAlbumCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(albumTitle)
        addSubview(background)
        addSubview(collectionView)
        addSubview(backButton)
        addSubview(leftBorder)
        
        let views:[String:UIView] = [
            "background":background,
            "backButton":backButton,
            "leftBorder":leftBorder,
            "albumTitle":albumTitle,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[leftBorder(1)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[albumTitle]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[backButton(44)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[leftBorder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBackButtonTop = NSLayoutConstraint(
            item:backButton,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kBackButtonTop)
        
        layoutBackgroundTop = NSLayoutConstraint(
            item:background,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kCollectionTop)
        
        layoutTitleBottom = NSLayoutConstraint(
            item:albumTitle,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:background,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBackButtonTop)
        addConstraint(layoutBackgroundTop)
        addConstraint(layoutTitleBottom)
    }
    
    override func layoutSubviews()
    {
        computeCellSize()
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: private
    
    private func computeCellSize()
    {
        let width:CGFloat = bounds.maxX - kInterLine
        let proximate:CGFloat = floor(width / MPhotos.kThumbnailSize)
        let size:CGFloat = (width / proximate) - kInterLine
        cellSize = CGSize(width:size, height:size)
    }
    
    private func modelAtIndex(index:IndexPath) -> MPhotosItemPhoto
    {
        let reference:MPhotosItemPhotoReference = controller.model.references[index.item]
        let item:MPhotosItemPhoto = MPhotos.sharedInstance.photos[reference.photoId]!
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        let yOffset:CGFloat = scrollView.contentOffset.y
        layoutBackgroundTop.constant = kCollectionTop - yOffset
        
        if yOffset > 0
        {
            let halfOffset:CGFloat = yOffset / 2.0
            var backButtonAlpha:CGFloat = 1 - (yOffset / 50.0)
            
            if backButtonAlpha < 0
            {
                backButtonAlpha = 0
            }
            
            layoutBackButtonTop.constant = kBackButtonTop - halfOffset
            layoutTitleBottom.constant = halfOffset
            backButton.alpha = backButtonAlpha
        }
        else
        {
            layoutBackButtonTop.constant = kBackButtonTop
            layoutTitleBottom.constant = 0
            backButton.alpha = 1
        }
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return cellSize
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.references.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPhotosItemPhoto = modelAtIndex(index:indexPath)
        let cell:VPhotosAlbumCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPhotosAlbumCell.reusableIdentifier,
            for:indexPath) as! VPhotosAlbumCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MPhotosItemPhoto = modelAtIndex(index:indexPath)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
