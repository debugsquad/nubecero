import Foundation

class MHomeUploadItemStatus
{
    let assetSync:String
    let finished:Bool
    
    init()
    {
        fatalError()
    }
    
    init(assetSync:String, finished:Bool)
    {
        self.assetSync = assetSync
        self.finished = finished
    }
}
