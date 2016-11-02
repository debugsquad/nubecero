import UIKit

class CPicturesData:CController
{
    weak var model:MPicturesItem!
    
    init(model:MPicturesItem)
    {
        self.model = model
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
