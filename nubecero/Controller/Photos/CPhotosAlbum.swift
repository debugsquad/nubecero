import UIKit

class CPhotosAlbum:CController
{
    private weak var viewAlbum:VPhotosAlbum!
    let model:MPhotosItem
    
    init(model:MPhotosItem)
    {
        self.model = model
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
        let viewAlbum:VPhotosAlbum = VPhotosAlbum(controller:self)
        self.viewAlbum = viewAlbum
        view = viewAlbum
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop()
    }
    
    func selectPhoto(item:Int, inRect:CGRect)
    {
        let controller:CPhotosAlbumPhoto = CPhotosAlbumPhoto(
            model:model,
            selected:item,
            inRect:inRect)
        
        parentController.over(
            controller:controller,
            pop:false,
            animate:false)
    }
}
