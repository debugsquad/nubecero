import UIKit

class VPhotosAlbumPhotoSettings:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotosAlbumPhotoSettings!
    private weak var collectionView:UICollectionView!
    private let kBarHeight:CGFloat = 120
    
    convenience init(controller:CPhotosAlbumPhotoSettings)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let bar:VPhotosAlbumPhotoSettingsBar = VPhotosAlbumPhotoSettingsBar(
            controller:controller)
        
        addSubview(bar)
        
        let views:[String:UIView] = [
            "bar":bar]
        
        let metrics:[String:CGFloat] = [
            "barHeight":kBarHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.ite
        
        return
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VPhotosAlbumPhotoSettingsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPhotosAlbumPhotoSettingsCell.reusableIdentifier,
            for:indexPath) as! VPhotosAlbumPhotoSettingsCell
        
        return cell
    }
}
