import UIKit

class VPhotosAlbumPhotoList:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var collectionView:UICollectionView!
    
    convenience init(controller:CPhotosAlbumPhoto)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPhotosItemPhoto
    {
        let reference:MPhotosItemPhotoReference = controller.model.references[
            index.item]
        let item:MPhotosItemPhoto = MPhotos.sharedInstance.photos[
            reference.photoId]!
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return collectionView.bounds.size
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
        let cell:VPhotosAlbumPhotoListCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPhotosAlbumPhotoListCell.reusableIdentifier,
            for:indexPath) as! VPhotosAlbumPhotoListCell
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
