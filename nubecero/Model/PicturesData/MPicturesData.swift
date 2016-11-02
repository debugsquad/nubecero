import Foundation

class MPicturesData
{
    let items:[MPicturesDataItem]
    
    init()
    {
        let itemClose:MPicturesDataItemClose = MPicturesDataItemClose()
        
        items = [
            itemClose
        ]
    }
}
