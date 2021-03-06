import UIKit

class VHomeUploadSync:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var viewBar:VHomeUploadSyncBar!
    private weak var collectionView:UICollectionView!
    private weak var controller:CHomeUploadSync!
    private var cellSize:CGSize!
    private let kBarHeight:CGFloat = 82
    private let kCollectionBottom:CGFloat = 20
    private let kInterLineSpace:CGFloat = 1
    
    convenience init(controller:CHomeUploadSync)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        visualEffect.isUserInteractionEnabled = false
        
        let viewBar:VHomeUploadSyncBar = VHomeUploadSyncBar(controller:controller)
        self.viewBar = viewBar
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = kInterLineSpace
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsetsMake(
            kInterLineSpace + kBarHeight,
            kInterLineSpace,
            kCollectionBottom,
            kInterLineSpace)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeUploadSyncCell.self,
            forCellWithReuseIdentifier:
            VHomeUploadSyncCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(visualEffect)
        addSubview(collectionView)
        addSubview(viewBar)
        
        let views:[String:UIView] = [
            "visualEffect":visualEffect,
            "viewBar":viewBar,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":kBarHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewBar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[viewBar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews()
    {
        computeCellSize()
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func computeCellSize()
    {
        let width:CGFloat = bounds.maxX - kInterLineSpace
        let proximate:CGFloat = floor(width / MPhotos.kThumbnailSize)
        let size:CGFloat = (width / proximate) - kInterLineSpace
        cellSize = CGSize(width:size, height:size)
    }
    
    private func modelAtIndex(index:IndexPath) -> MHomeUploadItem
    {
        let item:MHomeUploadItem = controller.uploadItems[index.item]
        
        return item
    }
    
    //MARK: public
    
    func stepCompleted()
    {
        collectionView.reloadData()
        viewBar.update()
    }
    
    func errorFound()
    {
        collectionView.reloadData()
        viewBar.errorFound()
        viewBar.update()
    }
    
    //MARK: collectionView delegate
    
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
        let count:Int = controller.uploadItems.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        let cell:VHomeUploadSyncCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VHomeUploadSyncCell.reusableIdentifier,
            for:indexPath) as! VHomeUploadSyncCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
