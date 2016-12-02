import XCTest
@testable import nubecero

class TFDatabaseModelPhoto:XCTestCase
{
    private let kLocalId:String = "9addas9auajadsjkhn331212aaddsa"
    private let kAlbumId:String = "sdaadadn2312312312nnb2"
    private let kCreated:TimeInterval = 1434342.344
    private let kTaken:TimeInterval = 34342.344
    private let kSize:Int = 2343545
    private let kPixelWidth:Int = 43532225
    private let kPixelHeight:Int = 534663123
    
    enum Property:String
    {
        case localId = "localId"
        case albumId = "albumId"
        case created = "created"
        case taken = "taken"
        case status = "status"
        case size = "size"
        case pixelWidth = "pixelWidth"
        case pixelHeight = "pixelHeight"
    }
    
    func testInitSnapshot()
    {
        let status:MPhotos.Status = MPhotos.Status.synced
        
        let keyLocalId:String = FDatabaseModelPhoto.Property.localId.rawValue
        let keyAlbumId:String = FDatabaseModelPhoto.Property.albumId.rawValue
        let keyCreated:String = FDatabaseModelPhoto.Property.created.rawValue
        let keyTaken:String = FDatabaseModelPhoto.Property.taken.rawValue
        let keyStatus:String = FDatabaseModelPhoto.Property.status.rawValue
        let keySize:String = FDatabaseModelPhoto.Property.size.rawValue
        let keyPixelWidth:String = FDatabaseModelPhoto.Property.pixelWidth.rawValue
        let keyPixelHeight:String = FDatabaseModelPhoto.Property.pixelHeight.rawValue
        
        let snapshot:[String:Any] = [
            keyLocalId:kLocalId,
            keyAlbumId:kAlbumId,
            keyCreated:kCreated,
            keyTaken:kTaken,
            keyStatus:status,
            keySize:kSize,
            keyPixelWidth:kPixelWidth,
            keyPixelHeight:kPixelHeight
        ]
        
        let model:FDatabaseModelPhoto = FDatabaseModelPicture(
            snapshot:snapshot)
        
        XCTAssertEqual(
            fDatabaseModelPicture.created,
            kCreated,
            "Error parsing created")
        
        XCTAssertEqual(
            fDatabaseModelPicture.status,
            status,
            "Error parsing status")
        
        XCTAssertEqual(
            fDatabaseModelPicture.size,
            kSize,
            "Error parsing size")
        
        let modelJson:[String:Any]? = fDatabaseModelPicture.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonCreated:TimeInterval? = modelJson![keyCreated] as? TimeInterval
        let jsonStatusInt:Int? = modelJson![keyStatus] as? Int
        let jsonSize:Int? = modelJson![keySize] as? Int
        
        XCTAssertEqual(
            kCreated,
            jsonCreated,
            "Created received from json is no the same as the stored")
        
        XCTAssertNotNil(
            jsonStatusInt,
            "Error storing status on json")
        
        let jsonStatus:FDatabaseModelPicture.Status? = FDatabaseModelPicture.Status(
            rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            status,
            jsonStatus,
            "Status received from json is no the same as the stored")
        
        XCTAssertEqual(
            kSize,
            jsonSize,
            "Size received from json is no the same as the stored")
    }
}
