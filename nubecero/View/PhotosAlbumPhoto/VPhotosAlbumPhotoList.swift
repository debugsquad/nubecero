import UIKit

class VPhotosAlbumPhotoList:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var collectionView:UICollectionView!
    var animate:Bool
    
    init(controller:CPhotosAlbumPhoto)
    {
        animate = true
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:VPhotosAlbumPhotoListFlow = VPhotosAlbumPhotoListFlow()
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPhotosAlbumPhotoListCell.self,
            forCellWithReuseIdentifier:
            VPhotosAlbumPhotoListCell.reusableIdentifier)
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
        
        let indexPath:IndexPath = IndexPath(
            item:controller.selected,
            section:0)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.collectionView.scrollToItem(
                at:indexPath,
                at:UICollectionViewScrollPosition.centeredHorizontally,
                animated:false)
        }
        
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
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        let width:CGFloat = scrollView.bounds.size.width
        let height:CGFloat = scrollView.bounds.size.height
        let width_2:CGFloat = width / 2.0
        let height_2:CGFloat = height / 2.0
        let xOffset:CGFloat = scrollView.contentOffset.x
        let point:CGPoint = CGPoint(
            x:width_2 + xOffset,
            y:height_2)
        
        guard
        
            let indexPath:IndexPath = collectionView.indexPathForItem(
                at:point)
        
        else
        {
            return
        }
        
        let selected:Int = indexPath.item
        controller.selected = selected
    }
    
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
        
        cell.config(controller:controller, model:item)
        
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
