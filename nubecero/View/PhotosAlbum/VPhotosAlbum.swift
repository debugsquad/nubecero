import UIKit

class VPhotosAlbum:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var collectionView:UICollectionView!
    private weak var controller:CPhotosAlbum!
    private weak var spinner:VSpinner!
    private weak var albumBar:VPhotosAlbumBar!
    private weak var albumTitle:VPhotosAlbumTitle!
    private weak var layoutBackgroundTop:NSLayoutConstraint!
    private weak var layoutBarTop:NSLayoutConstraint!
    private weak var layoutTitleBottom:NSLayoutConstraint!
    private var cellSize:CGSize!
    private let kInterLine:CGFloat = 1
    private let kCollectionTop:CGFloat = 130
    private let kBarHeight:CGFloat = 64
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
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        let albumBar:VPhotosAlbumBar = VPhotosAlbumBar(controller:controller)
        self.albumBar = albumBar
        
        let albumTitle:VPhotosAlbumTitle = VPhotosAlbumTitle(controller:controller)
        self.albumTitle = albumTitle
        
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
        addSubview(albumBar)
        addSubview(spinner)
        addSubview(leftBorder)
        
        let views:[String:UIView] = [
            "spinner":spinner,
            "background":background,
            "albumBar":albumBar,
            "leftBorder":leftBorder,
            "albumTitle":albumTitle,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":kBarHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[background]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[albumBar]-0-|",
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
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[albumBar(barHeight)]",
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
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBarTop = NSLayoutConstraint(
            item:albumBar,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
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
        
        addConstraint(layoutBarTop)
        addConstraint(layoutBackgroundTop)
        addConstraint(layoutTitleBottom)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedAlbumRefreshed(sender:)),
            name:Notification.albumRefreshed,
            object:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews()
    {
        computeCellSize()
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: notified
    
    func notifiedAlbumRefreshed(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.collectionView.reloadData()
            self?.albumTitle.print()
        }
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
    
    //MARK: public
    
    func showLoading()
    {
        collectionView.isHidden = true
        albumTitle.isHidden = true
        albumBar.isHidden = true
        spinner.startAnimating()
    }
    
    func hideLoading()
    {
        collectionView.isHidden = false
        albumTitle.isHidden = false
        albumBar.isHidden = false
        spinner.stopAnimating()
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
            
            layoutBarTop.constant = -halfOffset
            layoutTitleBottom.constant = halfOffset
            albumBar.alpha = backButtonAlpha
        }
        else
        {
            layoutBarTop.constant = 0
            layoutTitleBottom.constant = 0
            albumBar.alpha = 1
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
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
        
        guard
            
            let cell:UICollectionViewCell = collectionView.cellForItem(at:indexPath)
        
        else
        {
            return
        }
        
        let cellFrame:CGRect = cell.frame
        let offsetY:CGFloat = collectionView.contentOffset.y
        let cellLocation:CGRect = CGRect(
            x:cellFrame.origin.x,
            y:cellFrame.origin.y - offsetY,
            width:cellFrame.size.width,
            height:cellFrame.size.height)
        
        controller.selectPhoto(
            item:indexPath.item,
            inRect:cellLocation)
    }
}
