import Foundation

class MMain
{
    let items:[MMainItem]
    var state:MMainState
    weak var current:MMainItem!
    private weak var home:MMainItem!
    
    init()
    {
        state = MMainStateOptions()
        
        var items:[MMainItem] = []
        
        let itemSettings:MMainItemSettings = MMainItemSettings(index:items.count)
        items.append(itemSettings)
        
        let itemHome:MMainItemHome = MMainItemHome(index:items.count)
        home = itemHome
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
    
    func restart()
    {
        current = home
    }
}
