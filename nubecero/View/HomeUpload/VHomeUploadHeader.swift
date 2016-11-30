import UIKit

class VHomeUploadHeader:UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var collectionView:UICollectionView!
    private weak var controller:CHomeUpload?
    private var cellSize:CGSize!
    private var leftInset:CGFloat!
    private var model:MHomeUploadHeader?
    private let kDeselectTime:TimeInterval = 0.35
    private let kMaxCellWidth:CGFloat = 100
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.background
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
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
            VHomeUploadHeaderCell.self,
            forCellWithReuseIdentifier:
            VHomeUploadHeaderCell.reusableIdentifier)
        self.collectionView = collectionView
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor(white:0, alpha:0.2)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        
        addSubview(border)
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "collectionView":collectionView,
            "border":border]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        if let model:MHomeUploadHeader = self.model
        {
            let count:CGFloat = CGFloat(model.items.count)
            let width:CGFloat = bounds.maxX
            let height:CGFloat = bounds.maxY
            let cellsWidth:CGFloat = kMaxCellWidth * count
            let remainWidth:CGFloat = width - cellsWidth
            leftInset = remainWidth / 2.0
            cellSize = CGSize(width:kMaxCellWidth, height:height)
            collectionView.collectionViewLayout.invalidateLayout()
        }
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeUploadHeaderItem
    {
        let item:MHomeUploadHeaderItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func config(controller:CHomeUpload)
    {
        self.controller = controller
        refresh()
    }
    
    func refresh()
    {
        guard
            
            let controller:CHomeUpload = self.controller
        
        else
        {
            return
        }
        
        model = MHomeUploadHeader(controller:controller)
        setNeedsLayout()
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:0,
            left:leftInset,
            bottom:0,
            right:0)
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return cellSize
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if let countItems:Int = model?.items.count
        {
            count = countItems
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeUploadHeaderItem = modelAtIndex(
            index:indexPath)
        let cell:VHomeUploadHeaderCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHomeUploadHeaderCell.reusableIdentifier,
            for:indexPath) as! VHomeUploadHeaderCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MHomeUploadHeaderItem = modelAtIndex(
            index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
