import UIKit

class VAdminPurchases:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CAdminPurchases!
    private weak var spinner:VSpinner!
    private weak var collectionView:UICollectionView!
    private let kHeaderHeight:CGFloat = 70
    private let kInterLine:CGFloat = 1
    private let kCellHeight:CGFloat = 80
    private let kCollectionBottom:CGFloat = 20
    
    convenience init(controller:CAdminPurchases)
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
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(top:kInterLine, left:0, bottom:kCollectionBottom, right:0)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VAdminPurchasesHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VAdminPurchasesHeader.reusableIdentifier)
        collectionView.register(
            VAdminPurchasesCell.self,
            forCellWithReuseIdentifier:
            VAdminPurchasesCell.reusableIdentifier)
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
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[spinner]-0-|",
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
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    
    
    //MARK: public
    
    func completedLoading()
    {
        spinner.removeFromSuperview()
        collectionView.reloadData()
    }
    
    func errorLoading()
    {
        spinner.removeFromSuperview()
    }
    
    //MARK: collectionView delegate
    
    
}
