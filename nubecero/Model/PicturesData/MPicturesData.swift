import Foundation

class MPicturesData
{
    let items:[MPicturesDataItem]
    
    init()
    {
        let itemCreated:MPicturesDataItemCreated = MPicturesDataItemCreated()
        let itemSize:MPicturesDataItemSize = MPicturesDataItemSize()
        let itemClose:MPicturesDataItemClose = MPicturesDataItemClose()
        
        items = [
            itemCreated,
            itemSize,
            itemClose
        ]
    }
}
