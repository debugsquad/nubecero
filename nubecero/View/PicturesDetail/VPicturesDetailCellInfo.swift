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
        backgroundColor = UIColor.white
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPicturesDetailInfoItem
    {
        let item:MPicturesDetailInfoItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
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
