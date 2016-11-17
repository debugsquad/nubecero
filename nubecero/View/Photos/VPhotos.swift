import UIKit

class VPhotos:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotos!
    private weak var collectionView:UICollectionView!
    private let kInterLine:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 100
    
    convenience init(controller:CPhotos)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
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
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPhotosItem
    {
        let item:MPhotosItem = MPhotos.sharedInstance.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let count:Int = MPhotos.sharedInstance.items.count
        
        return count
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
