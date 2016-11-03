import UIKit

class VPictures:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var currentItem:MPicturesItem?
    private var currentItemIndex:Int?
    private weak var controller:CPictures!
    private weak var collectionView:UICollectionView!
    private weak var viewDetail:VPicturesDetail!
    private weak var spinner:VSpinner?
    private let kCollectionHeight:CGFloat = 80
    private let kCollectionMargin:CGFloat = 1
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CPictures)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let cellHeigh:CGFloat = kCollectionHeight - kCollectionMargin
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewDetail:VPicturesDetail = VPicturesDetail(controller:controller)
        viewDetail.isHidden = true
        self.viewDetail = viewDetail
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.itemSize = CGSize(width:cellHeigh, height:cellHeigh)
        flow.sectionInset = UIEdgeInsets(
            top:kCollectionMargin,
            left:kCollectionMargin,
            bottom:0,
            right:kCollectionMargin)
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPicturesCell.self,
            forCellWithReuseIdentifier:
            VPicturesCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(viewDetail)
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "spinner":spinner,
            "collectionView":collectionView,
            "viewDetail":viewDetail]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight,
            "collectionHeight":kCollectionHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewDetail]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[viewDetail]-0-[collectionView(collectionHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPicturesItem
    {
        let item:MPicturesItem = MPictures.sharedInstance.pictureAtIndex(index:index.item)
        
        return item
    }
    
    private func selectItemNumber(index:Int)
    {
        currentItemIndex = index
        currentItem?.countDown()
        currentItem = MPictures.sharedInstance.pictureAtIndex(index:index)
        viewDetail.refresh()
    }
    
    //MARK: public
    
    func picturesLoaded()
    {
        spinner?.removeFromSuperview()
        collectionView.isHidden = false
        collectionView.reloadData()
        viewDetail.isHidden = false
        
        let count:Int = MPictures.sharedInstance.references.count
        
        if count > 0
        {
            let itemSelected:Int = 0
            let indexPathSelected:IndexPath = IndexPath(item:itemSelected, section:0)
            
            collectionView.selectItem(
                at:indexPathSelected,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
            selectItemNumber(index:itemSelected)
        }
    }
    
    func removeSelected()
    {
        guard
        
            let currentItemIndex:Int = currentItemIndex
        
        else
        {
            return
        }
        
        MPictures.sharedInstance.removeItem(index:currentItemIndex)
        let count:Int = MPictures.sharedInstance.references.count
        let nextIndexPath:IndexPath?
        
        if currentItemIndex < count
        {
            nextIndexPath = IndexPath(item:currentItemIndex, section:0)
        }
        else if currentItemIndex == count && currentItemIndex > 0
        {
            nextIndexPath = IndexPath(item:currentItemIndex - 1, section:0)
        }
        else
        {
            self.currentItemIndex = nil
            self.currentItem = nil
            nextIndexPath = nil
        }
        
        collectionView.reloadData()
        
        guard
        
            let newItem:Int = nextIndexPath?.item
        
        else
        {
            viewDetail.refresh()
            
            return
        }
        
        collectionView.selectItem(
            at:nextIndexPath,
            animated:true,
            scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
        
        selectItemNumber(index:newItem)
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = MPictures.sharedInstance.references.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPicturesItem = modelAtIndex(index:indexPath)
        let cell:VPicturesCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VPicturesCell.reusableIdentifier,
            for:indexPath) as! VPicturesCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        selectItemNumber(index:indexPath.item)
        
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
    }
}
