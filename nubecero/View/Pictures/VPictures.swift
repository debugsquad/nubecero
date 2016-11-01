import UIKit

class VPictures:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CPictures!
    weak var collectionView:UICollectionView!
    weak var spinner:VSpinner!
    private let kCollectionHeight:CGFloat = 100
    private let kCollectionTop:CGFloat = 5
    private let kCollectionBottom:CGFloat = 10
    private let kCollectionHorizontal:CGFloat = 5
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CPictures)
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
        flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:kCollectionHorizontal,
            bottom:kCollectionBottom,
            right:kCollectionHorizontal)
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.isHidden = true
        collectionView.isUserInteractionEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VPicturesCell.self,
            forCellWithReuseIdentifier:
            VPicturesCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "spinner":spinner]
        
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
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPicturesItem
    {
        let reference
        let item:MPicturesItem = MPictures.sharedInstance.items[]
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = MPictures.sharedInstance.references.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPicturesItem = modelAtIndex(index:indexPath)
        let cell:VPicturesCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VPicturesCell.reusableIdentifier,
            for:indexPath) as! VPicturesCell
        cell.config(model:item)
        
        return cell
    }
}
