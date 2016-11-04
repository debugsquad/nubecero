import UIKit

class VPicturesDetail:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    private let model:MPicturesDetail
    private weak var controller:CPictures!
    private weak var collectionView:UICollectionView!
    private let kHeaderHeight:CGFloat = 200
    
    init(controller:CPictures)
    {
        model = MPicturesDetail()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.footerReferenceSize = CGSize.zero
        flow.sectionInset = UIEdgeInsets.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPicturesDetailHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VPicturesDetailHeader.reusableIdentifier)
        collectionView.register(
            VPicturesDetailCellInfo.self,
            forCellWithReuseIdentifier:
            VPicturesDetailCellInfo.reusableIdentifier)
        collectionView.register(
            VPicturesDetailCellImage.self,
            forCellWithReuseIdentifier:
            VPicturesDetailCellImage.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()   
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPicturesDetailItem
    {
        let item:MPicturesDetailItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MPicturesDetailItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let totalWeights:CGFloat = CGFloat(model.itemsWeight)
        let itemWeight:CGFloat = CGFloat(item.sizeWeight)
        let size:CGSize
        
        if height >= width
        {
            let heightDivided:CGFloat = height / totalWeights
            let itemHeight:CGFloat = floor(heightDivided * itemWeight)
            
            size = CGSize(width:width, height:itemHeight)
        }
        else
        {
            let widthDivided:CGFloat = width / totalWeights
            let itemWidth:CGFloat = floor(widthDivided * itemWeight)
            
            size = CGSize(width:itemWidth, height:height)
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let height:CGFloat
        
        if MPictures.sharedInstance.references.count > 0
        {
            height = 0
        }
        else
        {
            height = kHeaderHeight
        }
        
        let size:CGSize = CGSize(width:0, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if MPictures.sharedInstance.references.count > 0
        {
            count = model.items.count
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VPicturesDetailHeader.reusableIdentifier,
            for:indexPath)
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPicturesDetailItem = modelAtIndex(index:indexPath)
        let cell:VPicturesDetailCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VPicturesDetailCell
        cell.config(controller:controller)
        
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
