import UIKit

class VPhotosAlbumPhotoSettings:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotosAlbumPhotoSettings!
    private weak var collectionView:UICollectionView!
    private let kDeselectTime:TimeInterval = 1
    private let kBarHeight:CGFloat = 120
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CPhotosAlbumPhotoSettings)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let bar:VPhotosAlbumPhotoSettingsBar = VPhotosAlbumPhotoSettingsBar(
            controller:controller)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(
            top:0,
            left:0,
            bottom:0,
            right:kCollectionBottom)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPhotosAlbumPhotoSettingsCell.self,
            forCellWithReuseIdentifier:
            VPhotosAlbumPhotoSettingsCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(bar)
        
        let views:[String:UIView] = [
            "bar":bar,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":kBarHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPhotosAlbumPhotoSettingsItem
    {
        let item:MPhotosAlbumPhotoSettingsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MPhotosAlbumPhotoSettingsItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(
            width:width,
            height:item.cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPhotosAlbumPhotoSettingsItem = modelAtIndex(index:indexPath)
        let cell:VPhotosAlbumPhotoSettingsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPhotosAlbumPhotoSettingsCell.reusableIdentifier,
            for:indexPath) as! VPhotosAlbumPhotoSettingsCell
        cell.config(controller:controller, model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MPhotosAlbumPhotoSettingsItem = modelAtIndex(index:indexPath)
        
        return item.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MPhotosAlbumPhotoSettingsItem = modelAtIndex(index:indexPath)
        
        return item.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MPhotosAlbumPhotoSettingsItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
