import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemUpload:MHomeItemUpload = MHomeItemUpload()
        
        items = [
            itemUpload
        ]
    }
}
