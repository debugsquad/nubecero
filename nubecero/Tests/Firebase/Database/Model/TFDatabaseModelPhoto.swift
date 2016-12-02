import XCTest
@testable import nubecero

class TFDatabaseModelPhoto:XCTestCase
{
    private let kLocalId:String = "9addas9auajadsjkhn331212aaddsa"
    private let kAlbumId:MPhotos.AlbumId? = "sdaadadn2312312312nnb2"
    private let kCreated:TimeInterval = 1434342.344
    private let kTaken:TimeInterval = 34342.344
    private let kSize:Int = 2343545
    private let kPixelWidth:Int = 43532225
    private let kPixelHeight:Int = 534663123
    private let kEmpty:String = ""
    private let kNoTime:TimeInterval = 0
    private let kNoSize:Int = 0
    
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
            keyStatus:status.rawValue,
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
    
    func testInitProperties()
    {
        let currentTime:TimeInterval = Date().timeIntervalSince1970
        
        let model:FDatabaseModelPhoto = FDatabaseModelPhoto(
            localId:kLocalId,
            albumId:kAlbumId,
            taken:kTaken,
            size:kSize,
            pixelWidth:kPixelWidth,
            pixelHeight:kPixelHeight)
        
        XCTAssertEqual(
            model.localId,
            kLocalId,
            "Error parsing local id")
        
        XCTAssertEqual(
            model.albumId,
            kAlbumId,
            "Error parsing album id")
        
        XCTAssertGreaterThanOrEqual(
            model.created,
            currentTime,
            "Error with created")
        
        XCTAssertEqual(
            model.taken,
            kTaken,
            "Error parsing taken")
        
        XCTAssertEqual(
            model.status,
            MPhotos.Status.waiting,
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
    }
    
    func testInitNoAlbumId()
    {
        let model:FDatabaseModelPhoto = FDatabaseModelPhoto(
            localId:kLocalId,
            albumId:nil,
            taken:kTaken,
            size:kSize,
            pixelWidth:kPixelWidth,
            pixelHeight:kPixelHeight)
        
        XCTAssertEqual(
            model.albumId,
            kEmpty,
            "Error using default album id")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any = ""
        
        let model:FDatabaseModelPhoto = FDatabaseModelPhoto(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            MPhotos.Status.waiting,
            "Error snapshot nil not using waiting status")
        
        XCTAssertEqual(
            model.size,
            kNoSize,
            "Error snapshot nil not using size zero")
        
        XCTAssertEqual(
            model.pixelWidth,
            kNoSize,
            "Error snapshot nil not using width zero")
        
        XCTAssertEqual(
            model.pixelHeight,
            kNoSize,
            "Error snapshot nil not using height zero")
        
        XCTAssertEqual(
            model.created,
            kNoTime,
            "Error snapshot nil not using created no time")
        
        XCTAssertEqual(
            model.taken,
            kNoTime,
            "Error snapshot nil not using taken no time")
    }
    
    func testStatusWaiting()
    {
        let status:MPhotos.Status = MPhotos.Status.waiting
        let keyStatus:String = FDatabaseModelPhoto.Property.status.rawValue
        
        let snapshot:[String:Any] = [
            keyStatus:status.rawValue
        ]
        
        let model:FDatabaseModelPhoto = FDatabaseModelPhoto(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            status,
            "Error parsing status waiting")
        
        let modelJson:[String:AnyObject]? = model.modelJson() as? [String:AnyObject]
        let jsonStatusInt:Int? = modelJson?[keyStatus] as? Int
        let jsonStatus:MPhotos.Status? = MPhotos.Status(rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            jsonStatus,
            status,
            "Error status json")
    }
    
    func testStatusSynced()
    {
        let status:MPhotos.Status = MPhotos.Status.synced
        let keyStatus:String = FDatabaseModelPhoto.Property.status.rawValue
        
        let snapshot:[String:Any] = [
            keyStatus:status.rawValue
        ]
        
        let model:FDatabaseModelPhoto = FDatabaseModelPhoto(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            status,
            "Error parsing status synced")
        
        let modelJson:[String:AnyObject]? = model.modelJson() as? [String:AnyObject]
        let jsonStatusInt:Int? = modelJson?[keyStatus] as? Int
        let jsonStatus:MPhotos.Status? = MPhotos.Status(rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            jsonStatus,
            status,
            "Error status json")
    }
    
    func testStatusDeleting()
    {
        let status:MPhotos.Status = MPhotos.Status.deleting
        let keyStatus:String = FDatabaseModelPhoto.Property.status.rawValue
        
        let snapshot:[String:Any] = [
            keyStatus:status.rawValue
        ]
        
        let model:FDatabaseModelPhoto = FDatabaseModelPhoto(
            snapshot:snapshot)
        
        XCTAssertEqual(
            model.status,
            status,
            "Error parsing status deleting")
        
        let modelJson:[String:AnyObject]? = model.modelJson() as? [String:AnyObject]
        let jsonStatusInt:Int? = modelJson?[keyStatus] as? Int
        let jsonStatus:MPhotos.Status? = MPhotos.Status(rawValue:jsonStatusInt!)
        
        XCTAssertEqual(
            jsonStatus,
            status,
            "Error status json")
    }
}
