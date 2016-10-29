import UIKit

class VHomeUpload:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHomeUpload!
    private weak var spinner:VSpinner!
    private weak var collectionView:UICollectionView!
    private var imageSize:CGFloat!
    private let kCollectionBottom:CGFloat = 20
    
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
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsets(top:0, left:0, bottom:kCollectionBottom, right:0)
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.isHidden = true
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeUploadCell.self,
            forCellWithReuseIdentifier:
            VHomeUploadCell.reusableIdentifier)
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
        
        computeImageSize()
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
        let width:CGFloat = bounds.maxX
        let proximate:CGFloat = floor(width / MHomeUpload.kImageMaxSize)
        imageSize = width / proximate
    }
    
    private func modelAtIndex(index:IndexPath) -> MHomeUploadItem
    {
        let item:MHomeUploadItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
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
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        let size:CGSize = CGSize(width:imageSize, height:imageSize)
        
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
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        let cell:VHomeUploadCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VHomeUploadCell.reusableIdentifier,
            for:indexPath) as! VHomeUploadCell
        cell.config(model:item)
        
        return cell
    }
}