import Foundation

class MPicturesData
{
    let items:[MPicturesDataItem]
    
    init()
    {
        let itemSize:MPicturesDataItemSize = MPicturesDataItemSize()
        let itemClose:MPicturesDataItemClose = MPicturesDataItemClose()
        
        items = [
            itemSize,
            itemClose
        ]
    }
}
