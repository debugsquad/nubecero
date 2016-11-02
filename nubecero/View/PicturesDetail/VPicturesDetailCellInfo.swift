import UIKit

class VPicturesDetailCellInfo:VPicturesDetailCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPictures?
    private weak var collectionView:UICollectionView!
    private let model:MPicturesDetailInfo
    
    override init(frame:CGRect)
    {
        model = MPicturesDetailInfo()
        
        super.init(frame:frame)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPicturesDetailCellInfoCell.self,
            forCellWithReuseIdentifier:
            VPicturesDetailCellInfoCell.reusableIdentifier)
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
    
    private func modelAtIndex(index:IndexPath) -> MPicturesDetailInfoItem
    {
        let item:MPicturesDetailInfoItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let countItems:CGFloat = CGFloat(model.items.count)
        let size:CGSize
        
        if height >= width
        {
            let itemWidth:CGFloat = width / countItems
            size = CGSize(width:itemWidth, height:height)
        }
        else
        {
            let itemHeight:CGFloat = height / countItems
            size = CGSize(width:width, height:itemHeight)
        }
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPicturesDetailInfoItem = modelAtIndex(index:indexPath)
        let cell:VPicturesDetailCellInfoCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPicturesDetailCellInfoCell.reusableIdentifier,
            for:indexPath) as! VPicturesDetailCellInfoCell
        cell.config(model:item)
        
        return cell
    }
}
