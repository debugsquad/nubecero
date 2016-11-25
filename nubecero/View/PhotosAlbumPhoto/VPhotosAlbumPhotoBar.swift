import UIKit

class VPhotosAlbumPhotoBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CPhotosAlbumPhoto!
    private weak var collectionView:UICollectionView!
    private let model:MPhotosAlbumPhoto
    private let kDeselectTime:TimeInterval = 1
    private let kCellWidth:CGFloat = 50
    
    init(controller:CPhotosAlbumPhoto)
    {
        model = MPhotosAlbumPhoto()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.2)
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.black
        backButton.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 25)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor(white:1, alpha:0.2)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPhotosAlbumPhotoBarCell.self,
            forCellWithReuseIdentifier:
            VPhotosAlbumPhotoBarCell.reusableIdentifier)
        self.collectionView = collectionView
        addSubview(collectionView)
        
        addSubview(border)
        addSubview(backButton)
        addSubview(collectionView)
        
        let countCells:Int = model.items.count
        let cellsWidth:CGFloat = CGFloat(countCells) * kCellWidth
        
        let views:[String:UIView] = [
            "backButton":backButton,
            "border":border,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "cellsWidth":cellsWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[collectionView(cellsWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[backButton(64)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPhotosAlbumPhotoItem
    {
        let item:MPhotosAlbumPhotoItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:kCellWidth, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPhotosAlbumPhotoItem = modelAtIndex(index:indexPath)
        let cell:VPhotosAlbumPhotoBarCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VPhotosAlbumPhotoBarCell.reusableIdentifier,
            for:indexPath) as! VPhotosAlbumPhotoBarCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MPhotosAlbumPhotoItem = modelAtIndex(index:indexPath)
        
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
