import UIKit

class MPhotosItemPhotoResources
{
    private(set) var thumbnail:UIImage?
    private(set) var image:UIImage?
    private weak var timer:Timer?
    private let kThumbnailSize:CGFloat = 128
    private let kPictureTimeout:TimeInterval = 15
}
