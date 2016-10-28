import Foundation

class MMain
{
    let items:[MMainItem]
    var state:MMainState
    weak var current:MMainItem!
    
    init()
    {
        state = MMainStateOptions()
        
        var items:[MMainItem] = []
        
        let itemSettings:MMainItemSettings = MMainItemSettings(index:items.count)
        items.append(itemSettings)
        
        let itemHome:MMainItemHome = MMainItemHome(index:items.count)
        current = itemHome
        items.append(itemHome)
        
        let itemPictures:MMainItemPictures = MMainItemPictures(index:items.count)
        items.append(itemPictures)
        
        self.items = items
    }
    
    //MARK: public
    
    func pushed()
    {
        state = MMainStatePushed()
    }
    
    func poped()
    {
        state = MMainStateOptions()
    }
}
