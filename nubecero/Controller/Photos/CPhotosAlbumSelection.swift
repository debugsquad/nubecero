import UIKit

class CPhotosAlbumSelection:CController
{
    private weak var viewSelect:VPhotosAlbumSelection!
    private weak var delegate:CPhotosAlbumSelectionDelegate?
    
    convenience init(delegate:CPhotosAlbumSelectionDelegate)
    {
        self.init()
        self.delegate = delegate
    }
    
    override func loadView()
    {
        let viewSelect:VPhotosAlbumSelection = VPhotosAlbumSelection(controller:self)
        self.viewSelect = viewSelect
        view = viewSelect
    }
}
