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
        
        let model:FDatabaseModelPhoto = FDatabaseModelPhoto(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.localId,
            kLocalId,
            "Error parsing local id")
        
        XCTAssertEqual(
            model.albumId,
            kAlbumId,
            "Error parsing album id")
        
        XCTAssertEqual(
            model.created,
            kCreated,
            "Error parsing created")
        
        XCTAssertEqual(
            model.taken,
            kTaken,
            "Error parsing taken")
        
        XCTAssertEqual(
            model.status,
            status,
            "Error parsing status")
        
        XCTAssertEqual(
            model.size,
            kSize,
            "Error parsing size")
        
        XCTAssertEqual(
            model.pixelWidth,
            kPixelWidth,
            "Error parsing pixel width")
        
        XCTAssertEqual(
            model.pixelHeight,
            kPixelHeight,
            "Error parsing pixel height")
        
        let modelJson:[String:Any]? = model.modelJson() as? [String:Any]
        
        XCTAssertNotNil(
            modelJson,
            "Error creating model json")
        
        let jsonLocalId:String? = modelJson?[keyLocalId] as? String
        let jsonAlbumId:String? = modelJson?[keyAlbumId] as? String
        let jsonCreated:TimeInterval? = modelJson?[keyCreated] as? TimeInterval
        let jsonTaken:TimeInterval? = modelJson?[keyTaken] as? TimeInterval
        let jsonStatusInt:Int? = modelJson?[keyStatus] as? Int
        let jsonSize:Int? = modelJson?[keySize] as? Int
        let jsonPixelWidth:Int? = modelJson?[keyPixelWidth] as? Int
        let jsonPixelHeight:Int? = modelJson?[keyPixelHeight] as? Int
        
        XCTAssertNotNil(
            jsonStatusInt,
            "Error storing status on json")
        
        let jsonStatus:MPhotos.Status? = MPhotos.Status(rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            kLocalId,
            jsonLocalId,
            "Error local id not matching")
        
        XCTAssertEqual(
            kAlbumId,
            jsonAlbumId,
            "Error album id not matching")
        
        XCTAssertEqual(
            kCreated,
            jsonCreated,
            "Error created not matching")
        
        XCTAssertEqual(
            kTaken,
            jsonTaken,
            "Error taken not matching")
        
        XCTAssertEqual(
            status,
            jsonStatus,
            "Error status not matching")
        
        XCTAssertEqual(
            kSize,
            jsonSize,
            "Error size not matching")
        
        XCTAssertEqual(
            kPixelWidth,
            jsonPixelWidth,
            "Error pixel width not matching")
        
        XCTAssertEqual(
            kPixelHeight,
            jsonPixelHeight,
            "Error pixel height not matching")
    }
}
