import UIKit

class CPhotosAlbumSelection:CController
{
    private weak var viewSelect:VPhotosAlbumSelection!
    private weak var delegate:CPhotosAlbumSelectionDelegate?
    weak var currentAlbum:MPhotosItem?
    
    convenience init(currentAlbum:MPhotosItem?, delegate:CPhotosAlbumSelectionDelegate)
    {
        self.init()
        self.currentAlbum = currentAlbum
        self.delegate = delegate
    }
    
    override func loadView()
    {
        let viewSelect:VPhotosAlbumSelection = VPhotosAlbumSelection(controller:self)
        self.viewSelect = viewSelect
        view = viewSelect
    }
    
    //MARK: public
    
    func selected(index:IndexPath)
    {
        let reference:MPhotosItemReference = MPhotos.sharedInstance.albumReferences[index.item]
        
        guard
        
            let album:MPhotosItem = MPhotos.sharedInstance.albumItems[
                reference.albumId]
        
        else
        {
            cancel()
            
            return
        }
        
        parentController.dismiss
        { [weak delegate] in
            
            delegate?.albumSelected(album:album)
        }
    }
    
    func cancel()
    {
        parentController.dismiss(completion:nil)
    }
}
