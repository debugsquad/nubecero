import UIKit

class VHomeUpload:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CHomeUpload!
    weak var spinner:VSpinner!
    
    convenience init(controller:CHomeUpload)
    {
        self.init()
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
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
    
    private func modelAtIndex(index:IndexPath) -> MHomeUploadItem
    {
        let item:MHomeUploadItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func showError()
    {
        spinner.stopAnimating()
        
        let errorImage:UIImageView = UIImageView()
        errorImage.isUserInteractionEnabled = false
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorImage.clipsToBounds = true
        errorImage.contentMode = UIViewContentMode.center
        errorImage.image = #imageLiteral(resourceName: "assetGenericError")
        
        addSubview(errorImage)
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let views:[String:UIView] = [
            "errorImage":errorImage]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[errorImage]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[errorImage]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    func imagesLoaded()
    {
        spinner.stopAnimating()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        let size:CGSize = item.imageSize
        
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
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        let cell:VHomeUploadCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VHomeUploadCell.reusableIdentifier,
            for:indexPath) as! VHomeUploadCell
        cell.config(model:item)
        
        return cell
    }
}
