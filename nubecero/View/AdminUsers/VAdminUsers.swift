import UIKit

class VAdminUsers:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CAdminUsers!
    private weak var collectionView:UICollectionView!
    private weak var spinner:VSpinner!
    private let kCellHeight:CGFloat = 100
    
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
        
        addSubview(spinner)
        
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
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        guard
        
            let count:Int = controller.model?.items.count
        
        else
        {
            return 0
        }
        
        return count
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
}
