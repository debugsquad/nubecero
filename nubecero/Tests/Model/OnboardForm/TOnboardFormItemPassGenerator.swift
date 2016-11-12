import XCTest
@testable import nubecero

class TOnboardFormItemPassGenerator:XCTestCase
{
    private let kTryouts:Int = 1000
    private let kMinPasswordLength:Int = 6
    private let kMaxPasswordLength:Int = 20
    private let kFirstTierMin:Int = 48
    private let kFirstTierMax:Int = 57
    private let kSecondTierMin:Int = 65
    private let kSecondTierMax:Int = 90
    private let kThirdTierMin:Int = 97
    private let kThirdTierMax:Int = 122
    
    func testGeneratePassword()
    {
        let generator:MOnboardFormItemPassGenerator = MOnboardFormItemPassGenerator()
        
        for _:Int in 0 ..< kTryouts
        {
            let newPassword:MOnboardFormItemPassGenerator.Password = generator.generatePassword()
            let passLength:Int = newPassword.characters.count
            
            XCTAssertGreaterThanOrEqual(
                passLength,
                kMinPasswordLength,
                "Password doesn't have the minimum length required")
            XCTAssertLessThan(
                passLength,
                kMaxPasswordLength,
                "Password is too long")
            
            for characterIndex:Int in 0 ..< passLength
            {
                let character:Character = newPassword[
                    newPassword.index(
                        newPassword.startIndex,
                        offsetBy:characterIndex)]
                let minString:String = "\(character)"
                let unicode:UnicodeScalar? = UnicodeScalar(minString)
                
                XCTAssertNotNil(
                    unicode,
                    "character is not a valid unicode \(minString)")
                
                let intValue:Int = Int(unicode!.value)
                
                XCTAssertGreaterThanOrEqual(
                    intValue,
                    kFirstTierMin,
                    "invalid character on password \(minString)")
                
                if intValue > kFirstTierMax
                {
                    XCTAssertGreaterThanOrEqual(
                        intValue,
                        kSecondTierMin,
                        "invalid character on password \(minString)")
                    
                    if intValue > kSecondTierMax
                    {
                        XCTAssertGreaterThanOrEqual(
                            intValue,
                            kThirdTierMin,
                            "invalid character on password \(minString)")
                        XCTAssertLessThanOrEqual(
                            intValue,
                            kThirdTierMax,
                            "invalid character on password \(minString)")
                    }
                }
            }
        }
    }
}
