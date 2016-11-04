import UIKit

class CSettings:CController
{
    weak var viewSettings:VSettings!
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
}
