import UIKit

class VAdminUsersPhotos:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CAdminUsersPhotos!
    private weak var collectionView:UICollectionView!
    private weak var spinner:VSpinner!
    private var imageSize:CGSize!
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    private let kImageMaxSize:CGFloat = 150
    
    convenience init(controller:CAdminUsersPhotos)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(top:kInterLine, left:0, bottom:kCollectionBottom, right:0)
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VAdminUsersPhotosCell.self,
            forCellWithReuseIdentifier:
            VAdminUsersPhotosCell.reusableIdentifier)
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
        let proximate:CGFloat = floor(width / kImageMaxSize)
        let size:CGFloat = (width / proximate) - kInterLine
        imageSize = CGSize(width:size, height:size)
    }
    
    private func modelAtIndex(index:IndexPath) -> MAdminUsersPhotosItem
    {
        let item:MAdminUsersPhotosItem = controller.pictures!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func loadingError()
    {
        spinner.removeFromSuperview()
    }
    
    func loadingFinished()
    {
        spinner.removeFromSuperview()
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return imageSize
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        guard
        
            let _:MAdminUsersPhotos = controller.pictures
        
        else
        {
            return 0
        }
        
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.pictures!.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MAdminUsersPhotosItem = modelAtIndex(index:indexPath)
        let cell:VAdminUsersPhotosCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VAdminUsersPhotosCell.reusableIdentifier,
            for:indexPath) as! VAdminUsersPhotosCell
        cell.config(model:item)
        
        return cell
    }
}
