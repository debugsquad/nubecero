import XCTest
@testable import nubecero

class TFDatabaseModelAlbumList:XCTestCase
{
    private let kAlbumIdA:MPhotos.AlbumId = "album a"
    private let kAlbumIdB:MPhotos.AlbumId = "album b"
    private let kAlbumIdC:MPhotos.AlbumId = "album c"
    private let kEmpty:Any = ""
    private let kCreated:TimeInterval = 123456
    private let kNoAlbums:Int = 0
    
    func testInitSnapshot()
    {
        let keyCreated:String = FDatabaseModelAlbum.Property.created.rawValue
        
        let snapshot:[MSession.UserId:Any] = [
            kAlbumIdA:[
                keyCreated:kCreated
            ]
        ]
        
        let model:FDatabaseModelAlbumList = FDatabaseModelAlbumList(
            snapshot:snapshot)
        
        XCTAssertNotNil(
            model.items.first,
            "Error parsing first item")
        
        XCTAssertNotNil(
            model.items[kAlbumIdA],
            "Error parsing first item")
        
        XCTAssertEqual(
            model.items[kAlbumIdA]!.created,
            kCreated,
            "Error parsing album properties")
    }
    
    func testInitSnapshotEmpty()
    {
        let snapshot:[MSession.UserId:Any] = [
            kAlbumIdA:kEmpty,
            kAlbumIdB:kEmpty,
            kAlbumIdC:kEmpty
        ]
        
        let model:FDatabaseModelAlbumList = FDatabaseModelAlbumList(
            snapshot:snapshot)
        
        let snapshotKeys:[MSession.UserId] = Array(snapshot.keys)
        let countAlbums:Int = model.items.count
        let countSnapshotKeys:Int = snapshotKeys.count
        
        XCTAssertEqual(
            countSnapshotKeys,
            countAlbums,
            "Not the same amount of items parsed")
    }
    
    func testInitSnapshotNil()
    {
        let snapshot:Any = kEmpty
        
        let model:FDatabaseModelUserList = FDatabaseModelUserList(
            snapshot:snapshot)
        
        let countAlbums:Int = model.items.count
        
        XCTAssertEqual(
            countAlbums,
            kNoAlbums,
            "albums should be empty")
    }
}
