import UIKit

class MPicturesItem
{
    let pictureId:MPictures.PictureId
    let created:TimeInterval
    let size:Int
    var state:MPicturesItemState
    private(set) var thumbnail:UIImage?
    private(set) var image:UIImage?
    
    init(pictureId:MPictures.PictureId, firebasePicture:FDatabaseModelPicture)
    {
        self.pictureId = pictureId
        created = firebasePicture.created
        size = firebasePicture.size
        state = MPicturesItemStateNone(item:nil)
        state.item = self
    }
    
    //MARK: private
    
    private func asyncGenerateThumbnail()
    {/*
        guard
            
            let cgImage:CGImage = image?.cgImage
            
        else
        {
            
            return
        }
        
        let imageOriginalWidth:CGFloat = filtered.image.size.width
        let imageOriginalHeight:CGFloat = filtered.image.size.height
        let imageOriginalWidthInt:Int = Int(imageOriginalWidth)
        let imageOriginalHeightInt:Int = Int(imageOriginalHeight)
        let deltaLeft:Int = Int(ceil(percentLeft))
        let deltaRight:Int = Int(ceil(percentRight))
        let deltaTop:Int = Int(ceil(percentTop))
        let deltaBottom:Int = Int(ceil(percentBottom))
        let deltaHorizontal:Int = deltaLeft + deltaRight
        let deltaVertical:Int = deltaTop + deltaBottom
        let expectedWidth:Int = imageOriginalWidthInt - deltaHorizontal
        let expectedHeight:Int = imageOriginalHeightInt - deltaVertical
        let bitsPerComponent:Int = cgImage.bitsPerComponent
        let bitmapInfo:CGBitmapInfo = cgImage.bitmapInfo
        var bytesPerRow:Int = cgImage.bytesPerRow
        let drawRect:CGRect = CGRect(
            x:-deltaLeft,
            y:-deltaBottom,
            width:imageOriginalWidthInt,
            height:imageOriginalHeightInt)
        
        if bytesPerRow < kMinBytesPerRow
        {
            bytesPerRow = kMinBytesPerRow
        }
        
        guard
            
            let colorSpace:CGColorSpace = cgImage.colorSpace,
            let context:CGContext = CGContext.init(
                data:nil,
                width:expectedWidth,
                height:expectedHeight,
                bitsPerComponent:bitsPerComponent,
                bytesPerRow:bytesPerRow,
                space:colorSpace,
                bitmapInfo:bitmapInfo.rawValue)
            
            else
        {
            viewEdit.endCropMode()
            
            return
        }
        
        context.interpolationQuality = CGInterpolationQuality.high
        context.draw(
            cgImage,
            in:drawRect)
        
        guard
            
            let editedImage:CGImage = context.makeImage()
            
            else
        {
            viewEdit.endCropMode()
            
            return
        }
        
        let resultImage:UIImage = UIImage(cgImage:editedImage)
        filtered.image = resultImage
        filtered.viewFiltered.imageView.image = resultImage
        filtered.viewFiltered.background.image = resultImage
        viewEdit.imageView.image = resultImage
        
        viewEdit.endCropMode()*/
    }
    
    //MARK: public
    
    func cleanState()
    {
        state = MPicturesItemStateNone(item:nil)
    }
    
    func startLoadingImage()
    {
        state = MPicturesItemStateLoading(item:self)
    }
    
    func generateThumbnail(image:UIImage)
    {
        self.image = image
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncGenerateThumbnail()
        }
    }
}
