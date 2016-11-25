import UIKit

class VPhotosAlbumPhotoListCellImage:UIScrollView, UIScrollViewDelegate
{
    weak var imageView:UIImageView!
    private weak var controller:CPhotosAlbumPhoto!
    private weak var scrollView:UIScrollView!
    private let kMinZoomScale:CGFloat = 1
    private let kMaxZoomScale:CGFloat = 10
    private let kAnimationDuration:TimeInterval = 5
    private var animationFinished:Bool
    
    init(controller:CPhotosAlbumPhoto)
    {
        animationFinished = false
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let scrollView:UIScrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = kMaxZoomScale
        scrollView.minimumZoomScale = kMinZoomScale
        scrollView.zoomScale = kMinZoomScale
        scrollView.bounces = true
        scrollView.delegate = self
        self.scrollView = scrollView
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        scrollView.addSubview(imageView)
        addSubview(scrollView)
        
        if controller.viewPhoto.viewList.animate
        {
            let indexSelected:Int = controller.selected
            let photoReference:MPhotosItemPhotoReference = controller.model.references[indexSelected]
            let photo:MPhotosItemPhoto = MPhotos.sharedInstance.photos[photoReference.photoId]!
            let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
            let finalSize:CGSize = controller.view.bounds.size
            let maxWidth:CGFloat = finalSize.width
            let maxHeight:CGFloat = finalSize.height - barHeight
            let imageWidth:CGFloat = CGFloat(photo.width)
            let imageHeight:CGFloat = CGFloat(photo.height)
            let deltaWidth:CGFloat = imageWidth / maxWidth
            let deltaHeight:CGFloat = imageHeight / maxHeight
            let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
            let viewWidth:CGFloat = imageWidth / maxDelta
            let viewHeight:CGFloat = imageHeight / maxDelta
            let remainTop:CGFloat = maxHeight - viewHeight
            let remainLeft:CGFloat = maxWidth - viewWidth
            let marginTop:CGFloat = remainTop / 2.0
            let marginLeft:CGFloat = remainLeft / 2.0
            let viewRect:CGRect = CGRect(
                x:marginLeft,
                y:marginTop,
                width:viewWidth,
                height:viewHeight)
            let initialRect:CGRect = CGRect(
                x:controller.inRect.origin.x,
                y:controller.inRect.origin.y - barHeight,
                width:controller.inRect.size.width,
                height:controller.inRect.size.height)
            
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            imageView.frame = initialRect
            
            let animationDuration:TimeInterval = kAnimationDuration
            
            DispatchQueue.main.async
            {
                UIView.animate(
                    withDuration:animationDuration,
                    animations:
                    {
                        imageView.frame = viewRect
                    })
                { [weak self] (done:Bool) in
                    
                    guard
                        
                        let bounds:CGRect = self?.bounds
                        
                    else
                    {
                        return
                    }
                    
                    controller.viewPhoto.viewList.animate = false
                    imageView.contentMode = UIViewContentMode.scaleAspectFit
                    imageView.frame = bounds
                    self?.animationFinished = true
                }
            }
        }
        else
        {
            animationFinished = true
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.frame = controller.view.frame
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            guard
            
                let bounds:CGRect = self?.bounds,
                let animationFinished:Bool = self?.animationFinished
            
            else
            {
                return
            }
            
            self?.scrollView.frame = bounds
            
            if animationFinished
            {
                self?.imageView.frame = bounds
            }
        }
        
        super.layoutSubviews()
    }
    
    func viewForZooming(in scrollView:UIScrollView) -> UIView?
    {
        return imageView
    }
}
