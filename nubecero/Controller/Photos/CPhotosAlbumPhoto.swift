import UIKit

class CPhotosAlbumPhoto:CController
{
    private weak var viewPhoto:VPhotosAlbumPhoto!
    weak var model:MPhotosItemPhoto!
    let inRect:CGRect
    
    init(model:MPhotosItemPhoto, inRect:CGRect)
    {
        self.model = model
        self.inRect = inRect
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewPhoto:VPhotosAlbumPhoto = VPhotosAlbumPhoto(controller:self)
        self.viewPhoto = viewPhoto
        view = viewPhoto
    }
    
    //MARK: public
    
    func back()
    {
        parentController.dismiss()
    }
}
