import UIKit

class VPhotos:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotos!
    
    convenience init(controller:CPhotos)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
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
