import UIKit

class VHomeUpload:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var collectionView:UICollectionView!
    private weak var controller:CHomeUpload!
    private weak var spinner:VSpinner!
    private var imageSize:CGSize!
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    private let kHeaderHeight:CGFloat = 90
    
    convenience init(controller:CHomeUpload)
    {
        self.init()
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsets(
            top:kInterLine,
            left:kInterLine,
            bottom:kCollectionBottom,
            right:kInterLine)
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.isHidden = true
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeUploadCellActive.self,
            forCellWithReuseIdentifier:
            VHomeUploadCellActive.reusableIdentifier)
        collectionView.register(
            VHomeUploadCellClouded.self,
            forCellWithReuseIdentifier:
            VHomeUploadCellClouded.reusableIdentifier)
        collectionView.register(
            VHomeUploadHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VHomeUploadHeader.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "spinner":spinner,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews()
    {
        computeImageSize()
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func computeImageSize()
    {
        let width:CGFloat = bounds.maxX - kInterLine
        let proximate:CGFloat = floor(width / MPhotos.kThumbnailSize)
        let size:CGFloat = (width / proximate) - kInterLine
        imageSize = CGSize(width:size, height:size)
    }
    
    private func modelAtIndex(index:IndexPath) -> MHomeUploadItem
    {
        let item:MHomeUploadItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func updateBar()
    {
        guard
            
            let amount:Int = collectionView.indexPathsForSelectedItems?.count
            
        else
        {
            return
        }
        
        controller.viewBar?.config(amount:amount)
    }
    
    func showError()
    {
        spinner.stopAnimating()
        
        let errorImage:UIImageView = UIImageView()
        errorImage.isUserInteractionEnabled = false
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorImage.clipsToBounds = true
        errorImage.contentMode = UIViewContentMode.center
        errorImage.image = #imageLiteral(resourceName: "assetGenericError")
        
        addSubview(errorImage)
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let views:[String:UIView] = [
            "errorImage":errorImage]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[errorImage]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[errorImage]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    func imagesLoaded()
    {
        spinner.stopAnimating()
        collectionView.reloadData()
        collectionView.isHidden = false
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return imageSize
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
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:VHomeUploadHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VHomeUploadHeader.reusableIdentifier,
            for:indexPath) as! VHomeUploadHeader
        reusable.config(controller:controller)
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        let cell:VHomeUploadCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.status.reusableIdentifier,
            for:indexPath) as! VHomeUploadCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        return item.status.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        return item.status.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldDeselectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        return item.status.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        item.statusWaiting()
        
        updateBar()
    }
    
    func collectionView(_ collectionView:UICollectionView, didDeselectItemAt indexPath:IndexPath)
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        if !item.status.finished
        {
            item.statusClear()
        }
        
        updateBar()
    }
}
