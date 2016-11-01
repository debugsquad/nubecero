import Foundation

class MPictures
{
    static let sharedInstance:MPictures = MPictures()
    var items:[MPicturesItem]
    
    private init()
    {
        items = []
    }
}
