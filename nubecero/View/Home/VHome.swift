import UIKit

class VHome:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    private weak var spinner:VSpinner?
    private let kInterLine:CGFloat = 1
    private let kCollectionTop:CGFloat = 5
    private let kCollectionBottom:CGFloat = 20
    private let kDeselectTime:TimeInterval = 1
    
    convenience init(controller:CHome)
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
        flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.isHidden = true
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeCellUpload.self,
            forCellWithReuseIdentifier:
            VHomeCellUpload.reusableIdentifier)
        collectionView.register(
            VHomeCellSpace.self,
            forCellWithReuseIdentifier:
            VHomeCellSpace.reusableIdentifier)
        collectionView.register(
            VHomeCellSpaceFree.self,
            forCellWithReuseIdentifier:
            VHomeCellSpaceFree.reusableIdentifier)
        collectionView.register(
            VHomeCellSpaceUsed.self,
            forCellWithReuseIdentifier:
            VHomeCellSpaceUsed.reusableIdentifier)
        collectionView.register(
            VHomeCellDisk.self,
            forCellWithReuseIdentifier:
            VHomeCellDisk.reusableIdentifier)
        collectionView.register(
            VHomeCellBlank.self,
            forCellWithReuseIdentifier:
            VHomeCellBlank.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(spinner)
        
        let views:[String:UIView] = [
            "collectionView":collectionView,
            "spinner":spinner]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
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
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeItem
    {
        let item:MHomeItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func sessionLoaded()
    {
        collectionView.reloadData()
        collectionView.isHidden = false
        spinner?.removeFromSuperview()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:item.cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
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
        let item:MHomeItem = modelAtIndex(index:indexPath)
        let cell:VHomeCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:item.reusableIdentifier,
            for:indexPath) as! VHomeCell
        cell.config(controller:controller, model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
        
        return item.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
        
        return item.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
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
