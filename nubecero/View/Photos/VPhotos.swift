import UIKit

class VPhotos:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotos!
    private weak var collectionView:UICollectionView!
    private let kInterLine:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 70
    private let kHeaderHeight:CGFloat = 80
    
    convenience init(controller:CPhotos)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        flow.footerReferenceSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = kInterLine
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(top:0, left:0, bottom:kCollectionBottom, right:0)
        
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
            VPhotosCell.self,
            forCellWithReuseIdentifier:
            VPhotosCell.reusableIdentifier)
        collectionView.register(
            VPhotosHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VPhotosHeader.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPhotosItem
    {
        let item:MPhotosItem = MPhotos.sharedInstance.items[index.item]
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let count:Int = MPhotos.sharedInstance.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let header:VPhotosHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VPhotosHeader.reusableIdentifier,
            for:indexPath) as! VPhotosHeader
        header.config(controller:controller)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPhotosItem = modelAtIndex(index:indexPath)
        let cell:VPhotosCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPhotosCell.reusableIdentifier,
            for:indexPath) as! VPhotosCell
        cell.config(model:item)
        
        return cell
    }
}
