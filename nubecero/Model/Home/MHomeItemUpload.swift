import UIKit

class MHomeItemUpload:MHomeItem
{
    private let kCellHeight:CGFloat = 55
    private let kSelectable:Bool = true
    
    override init()
    {
        let reusableIdentifier:String = VHomeCellUpload.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight,
            selectable:kSelectable)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.uploadPictures()
    }
}
