import UIKit

class CPhotosAlbumPhoto:CController
{
    weak var viewPhoto:VPhotosAlbumPhoto!
    var selected:Int
    let model:MPhotosItem
    let inRect:CGRect
    
    init(model:MPhotosItem, selected:Int, inRect:CGRect)
    {
        self.model = model
        self.selected = selected
        self.inRect = inRect
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewWillAppear(_ animated:Bool)
    {
        super.viewWillAppear(animated)
        parentController.statusBarDefault()
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.statusBarLight()
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
