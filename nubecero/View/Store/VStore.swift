import UIKit

class VStore:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CStore!
    private weak var viewSpinner:VSpinner?
    private weak var collectionView:UICollectionView!
    private let kHeaderHeight:CGFloat = 150
    private let kFooterHeight:CGFloat = 70
    private let kInterLine:CGFloat = 1
    private let kCollectionBottom:CGFloat = 10
    
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
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(top:kInterLine, left:0, bottom:kCollectionBottom, right:0)
        
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
            VStoreCellNotAvailable.self,
            forCellWithReuseIdentifier:
            VStoreCellNotAvailable.reusableIdentifier)
        collectionView.register(
            VStoreCellDeferred.self,
            forCellWithReuseIdentifier:
            VStoreCellDeferred.reusableIdentifier)
        collectionView.register(
            VStoreCellNew.self,
            forCellWithReuseIdentifier:
            VStoreCellNew.reusableIdentifier)
        collectionView.register(
            VStoreCellPurchased.self,
            forCellWithReuseIdentifier:
            VStoreCellPurchased.reusableIdentifier)
        collectionView.register(
            VStoreCellPurchasing.self,
            forCellWithReuseIdentifier:
            VStoreCellPurchasing.reusableIdentifier)
        collectionView.register(
            VStoreHeader.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VStoreHeader.reusableIdentifier)
        collectionView.register(
            VStoreFooter.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VStoreFooter.reusableIdentifier)
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
        let itemId:MStore.PurchaseId = controller.model.references[index.section]
        let item:MStoreItem = controller.model.mapItems[itemId]!
        
        return item
    }
    
    //MARK: public
    
    func refreshStore()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewSpinner?.removeFromSuperview()
            self?.collectionView.reloadData()
            self?.collectionView.isHidden = false
            
            guard
            
                let errorMessage:String = self?.controller.model.error
            
            else
            {
                return
            }
            
            VAlert.message(message:errorMessage)
        }
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let indexPath:IndexPath = IndexPath(item:0, section:section)
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let size:CGSize
        
        if item.status?.restorable == true
        {
            size = CGSize(width:0, height:kFooterHeight)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
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
        let count:Int = controller.model.references.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let indexPath:IndexPath = IndexPath(item:0, section:section)
        let item:MStoreItem = modelAtIndex(index:indexPath)
        let count:Int
        
        if item.status == nil
        {
            count = 0
        }
        else
        {
            count = 1
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let item:MStoreItem = modelAtIndex(index:indexPath)
            let header:VStoreHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VStoreHeader.reusableIdentifier,
                for:indexPath) as! VStoreHeader
            header.config(model:item)
            reusable = header
        }
        else
        {
            let footer:VStoreFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VStoreFooter.reusableIdentifier,
                for:indexPath) as! VStoreFooter
            footer.config(controller:controller)
            
            reusable = footer
        }
        
        return reusable
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
