import Foundation
import MLKitVision

public enum ExpoMlkitImageError:Error {
    case invalidImageURL(imagePath:String)
    case couldNotLoadImage(imagePath:String)
}


public class ExpoMlkitImage {

    public var imageURL: URL
    public var uiImage: UIImage
    public var visionImage: VisionImage

    public init(imagePath:String) throws {
        guard let imageURL = URL(string:imagePath) else {
            throw ExpoMlkitImageError.invalidImageURL(imagePath:imagePath)
        }

        self.imageURL = imageURL;


        guard let uiImage = UIImage(contentsOfFile: imageURL.path) else {
            throw ExpoMlkitImageError.couldNotLoadImage(imagePath:imageURL.path)
        }

        self.uiImage = uiImage

        visionImage = VisionImage(image:uiImage)
        visionImage.orientation = uiImage.imageOrientation

    }





}
