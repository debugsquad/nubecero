import UIKit

class VAdminUsers:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CAdminUsers!
    private weak var collectionView:UICollectionView!
    private weak var spinner:VSpinner!
    private let kHeaderHeight:CGFloat = 60
    private let kCellHeight:CGFloat = 100
    private let kInterLine:CGFloat = 3
    private let kCollectionBottom:CGFloat = 20
    private let kDeselectTime:TimeInterval = 1
    
    convenience init(controller:CAdminUsers)
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
        flow.headerReferenceSize = CGSize(width:0, height:barHeight + kHeaderHeight)
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(top:0, left:0, bottom:kCollectionBottom, right:0)
        
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
            VAdminUsersHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VAdminUsersHeader.reusableIdentifier)
        collectionView.register(
            VAdminUsersCell.self,
            forCellWithReuseIdentifier:
            VAdminUsersCell.reusableIdentifier)
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
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MAdminUsersItem
    {
        let item:MAdminUsersItem = controller.model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func loadingError()
    {
        spinner.removeFromSuperview()
    }
    
    func loadingCompleted()
    {
        spinner.removeFromSuperview()
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        guard
            
            let _:MAdminUsers = controller.model
            
        else
        {
            return 0
        }
        
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model!.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:VAdminUsersHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VAdminUsersHeader.reusableIdentifier,
            for:indexPath) as! VAdminUsersHeader
        reusable.config(controller:controller)
        
        return reusable
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let item:MAdminUsersItem = modelAtIndex(index:indexPath)
        let cell:VAdminUsersCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VAdminUsersCell.reusableIdentifier,
            for:indexPath) as! VAdminUsersCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MAdminUsersItem = modelAtIndex(index:indexPath)
        controller.selected(item:item)
        
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
