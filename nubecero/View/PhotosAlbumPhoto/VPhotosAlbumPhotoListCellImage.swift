import UIKit

class VPhotosAlbumPhotoListCellImage:UIScrollView, UIScrollViewDelegate
{
    weak var imageView:UIImageView!
    private weak var controller:CPhotosAlbumPhoto!
    private weak var scrollView:UIScrollView!
    private let kMinZoomScale:CGFloat = 1
    private let kMaxZoomScale:CGFloat = 10
    private let kAnimationDuration:TimeInterval = 0.3
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
        scrollView.zoomScale = kMinZoomScale
        scrollView.maximumZoomScale = kMaxZoomScale
        scrollView.minimumZoomScale = kMinZoomScale
        scrollView.bounces = true
        scrollView.delegate = self
        self.scrollView = scrollView
        
        let imageView:UIImageView = UIImageView(
            frame:controller.inRect)
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        scrollView.addSubview(imageView)
        addSubview(scrollView)
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            {
                imageView.frame = controller.view.bounds
            })
        { [weak self] (done:Bool) in
            
            self?.animationFinished = true
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
