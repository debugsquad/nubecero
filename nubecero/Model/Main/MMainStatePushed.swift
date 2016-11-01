import Foundation

class MMainStatePushed:MMainState
{
    override init()
    {
    }
    
    override func showBackButton() -> Bool
    {
        return true
    }
    
    override func showTitle() -> Bool
    {
        return true
    }
}
