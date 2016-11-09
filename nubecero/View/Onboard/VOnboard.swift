import UIKit

class VOnboard:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var viewOptions:VOnboardOptions!
    private weak var controller:COnboard!
    private weak var collectionView:UICollectionView!
    private weak var labelDisclaimer:UILabel!
    private weak var pageController:UIPageControl!
    private let kOptionsHeight:CGFloat = 34
    private let kDisclaimerHeight:CGFloat = 70
    private let kPageControlHeight:CGFloat = 15
    
    convenience init(controller:COnboard)
    {
        self.init()
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.controller = controller
        
        let pageControl:UIPageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor.complement
        pageControl.pageIndicatorTintColor = UIColor.complement.withAlphaComponent(0.2)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = controller.model.items.count
        pageControl.currentPage = 0
        self.pageController = pageControl
        
        let viewOptions:VOnboardOptions = VOnboardOptions(controller:controller)
        self.viewOptions = viewOptions
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VOnboardCell.self,
            forCellWithReuseIdentifier:
            VOnboardCell.reusableIdentifier)
        self.collectionView = collectionView
        
        let labelDisclaimer:UILabel = UILabel()
        labelDisclaimer.isUserInteractionEnabled = false
        labelDisclaimer.translatesAutoresizingMaskIntoConstraints = false
        labelDisclaimer.backgroundColor = UIColor.clear
        labelDisclaimer.font = UIFont.regular(size:13)
        labelDisclaimer.textColor = UIColor(white:0.3, alpha:1)
        labelDisclaimer.numberOfLines = 0
        labelDisclaimer.textAlignment = NSTextAlignment.center
        labelDisclaimer.text = NSLocalizedString("VOnboard_labelDisclaimer", comment:"")
        self.labelDisclaimer = labelDisclaimer
        
        addSubview(collectionView)
        addSubview(labelDisclaimer)
        addSubview(viewOptions)
        addSubview(pageControl)
        
        let views:[String:UIView] = [
            "collectionView":collectionView,
            "viewOptions":viewOptions,
            "labelDisclaimer":labelDisclaimer,
            "pageControl":pageControl]
        
        let metrics:[String:CGFloat] = [
            "optionsHeight":kOptionsHeight,
            "disclaimerHeight":kDisclaimerHeight,
            "pageControlHeight":kPageControlHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewOptions]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelDisclaimer]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[pageControl]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:
            "V:|-0-[collectionView]-0-[pageControl(pageControlHeight)]-5-[viewOptions(optionsHeight)]-0-[labelDisclaimer(disclaimerHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews()
    {
        collectionView.contentOffset = CGPoint.zero
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MOnboardItem
    {
        let item:MOnboardItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        let offsetX:CGFloat = scrollView.contentOffset.x
        let point:CGPoint = CGPoint(x:offsetX, y:1)
        
        guard
            
            let indexPath:IndexPath = collectionView.indexPathForItem(at:point)
        
        else
        {
            return
        }
        
        let itemPath:Int = indexPath.item
        pageController.currentPage = itemPath
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:width, height:height)
        
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
        let item:MOnboardItem = modelAtIndex(index:indexPath)
        let cell:VOnboardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VOnboardCell.reusableIdentifier,
            for:indexPath) as! VOnboardCell
        cell.config(model:item)
        
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
