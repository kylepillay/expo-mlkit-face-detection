import ExpoModulesCore
import MLKitFaceDetection

func rejectPromiseWithMessage(promise: Promise, message: String, domain: String) {
    promise.reject(
        NSError(domain: domain, code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    )
}

let ERROR_DOMAIN: String = "come.kylepillay.expomlkit.FaceDetectorErrorDomain"

public class ExpoMlkitFaceDetectionModule: Module {
  var faceDetector: ExpoMlkitFaceDetector? = nil
  public func definition() -> ModuleDefinition {

    Name("ExpoMlkitFaceDetection")

    AsyncFunction("initialize") { (record: ExpoMlkitFaceDetectorOptionsRecord, promise: Promise) in
            let options = ExpoMlkitFaceDetectorOptions(record: record)
            self.faceDetector = ExpoMlkitFaceDetector(options: options)
            promise.resolve()
        }

    AsyncFunction("detectFaces") { (imagePath: String, promise: Promise) in
        Task {
            do {
                guard let faceDetector = self.faceDetector else {
                    rejectPromiseWithMessage(promise: promise, message: "[ExpoMlkitFaceDetection.detectFace] Face detector not initialized", domain: ERROR_DOMAIN)
                    return
                }
                let image = try ExpoMlkitImage(imagePath: imagePath)
                let result = try await faceDetector.detectFaces(image: image)
                // Use result to resolve promise
                promise.resolve(result.record)

            } catch {
                rejectPromiseWithMessage(promise: promise, message: "[ExpoMlkitFaceDetection.detectFace] Error Detecting Faces: \(error)", domain: ERROR_DOMAIN)
            }
        }
    }
  }
}
