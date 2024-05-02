import Foundation
import MLKitFaceDetection

enum ExpoMlkitFaceDetectorError:Error {
    /// The model was not found at the specified modelPath
    case detectorNotInitialized
    case classificationError(error:Error)
}

class ExpoMlkitFaceDetector {
    var faceDetector: FaceDetector?

    init(
        options: ExpoMlkitFaceDetectorOptions
    ) {
        self.setOptions(options: options)

        return
    }

    func setOptions(
        options:ExpoMlkitFaceDetectorOptions
    ) {
        self.faceDetector = FaceDetector.faceDetector(options: options.options)
    }

    func detectFaces(image: ExpoMlkitImage) async throws -> ExpoMlkitFaceDetectionResult {
        guard let faceDetector = self.faceDetector else {
            throw ExpoMlkitFaceDetectorError.detectorNotInitialized
        }

        do {
            let faces: [Face] = try await faceDetector.process(image.visionImage)
            return ExpoMlkitFaceDetectionResult(faces: faces, imagePath: image.imageURL.absoluteString)
        } catch {
            throw ExpoMlkitFaceDetectorError.classificationError(error: error)
        }
    }

}
