import UIKit

class VStore:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CStore!
    weak var viewSpinner:VSpinner!
    weak var collectionView:UICollectionView!
    private let kHeaderHeight:CGFloat = 75
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CStore)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let viewSpinner:VSpinner = VSpinner()
        self.viewSpinner = viewSpinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
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
            VStoreCell.self,
            forCellWithReuseIdentifier:
            VStoreCell.reusableIdentifier)
        collectionView.register(
            VStoreHeader.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VStoreHeader.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(viewSpinner)
        
        let views:[String:UIView] = [
            "viewSpinner":viewSpinner,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewSpinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[viewSpinner]-0-|",
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
    
    private func modelAtIndex(index:IndexPath) -> MStoreItem
    {
        let itemId:MStore.PurchaseId = controller.model!.listReferences![index.section]
        let item:MStoreItem = controller.model!.mapItems![itemId]!
        
        return item
    }
    
    //MARK: public
    
    func showLoading()
    {
        collectionView.isHidden = true
        viewSpinner.startAnimating()
    }
    
    func refreshStore()
    {
        viewSpinner.stopAnimating()
        collectionView.reloadData()
        collectionView.isHidden = false
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let cellHeight:CGFloat = item.status!.cellHeight
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        guard
        
            let count:Int = controller.model?.listReferences?.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let indexPath:IndexPath = IndexPath(item:0, section:section)
        let item:MStoreItem = modelAtIndex(index:indexPath)
        
        guard
        
            let _:MStoreItemStatus = item.status
        
        else
        {
            return 0
        }
        
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let header:VStoreHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VStoreHeader.reusableIdentifier,
            for:indexPath) as! VStoreHeader
        header.config(model:item)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let reusableIdentifier:String = item.status!.reusableIdentifier
        
        let cell:VStoreCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            reusableIdentifier,
            for:indexPath) as! VStoreCell
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
