import UIKit

class MOnboardFormItemPassGenerator:MOnboardFormItem
{
    typealias Password = String
    private let kCellHeight:CGFloat = 42
    private let kPasswordMinLength:Int = 6
    private let kPasswordExtensionLength:UInt32 = 5
    private let kMinLowerCaseUnicode:Int = 65
    private let kLowerCaseUnicodeRange:UInt32 = 26
    private let kMinUpperCaseUnicode:Int = 97
    private let kUpperCaseUnicodeRange:UInt32 = 26
    private let kMinNumericUnicode:Int = 48
    private let kNumericUnicodeRange:UInt32 = 10
    
    override init()
    {
        let reusableIdentifier:String = VOnboardFormCellPassGenerator.reusableIdentifier
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func lowerCaseUnicode() -> Int
    {
        let unicodeValue:Int = kMinLowerCaseUnicode + Int(arc4random_uniform(kLowerCaseUnicodeRange))
        
        return unicodeValue
    }
    
    private func upperCaseUnicode() -> Int
    {
        let unicodeValue:Int = kMinUpperCaseUnicode + Int(arc4random_uniform(kUpperCaseUnicodeRange))
        
        return unicodeValue
    }
    
    private func numericUnicode() -> Int
    {
        let unicodeValue:Int = kMinNumericUnicode + Int(arc4random_uniform(kNumericUnicodeRange))
        
        return unicodeValue
    }
    
    private func passwordItem() -> String
    {
        let unicodeValue:Int
        let unicode:UnicodeScalar
        let character:Character
        let string:String
        let selectUnicode:UInt32 = arc4random_uniform(3)
        
        switch selectUnicode
        {
            case 0:
            
                unicodeValue = lowerCaseUnicode()
                
                break
            
            case 1:
            
                unicodeValue = upperCaseUnicode()
                
                break
            
            case 2:
                
                unicodeValue = numericUnicode()
            
                break
            
            default:
            
                unicodeValue = kMinNumericUnicode
                
                break
        }
        
        unicode = UnicodeScalar(unicodeValue)!
        character = Character(unicode)
        string = String(character)
        
        return string
    }
    
    //MARK: public
    
    func generatePassword() -> Password
    {
        let extendPassword:Int = Int(arc4random_uniform(kPasswordExtensionLength))
        let passwordLength:Int = kPasswordMinLength + extendPassword
        var password:Password = ""
        
        for _:Int in 0 ..< passwordLength
        {
            password += passwordItem()
        }
        
        return password
    }
}
