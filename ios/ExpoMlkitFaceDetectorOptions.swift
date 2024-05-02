import ExpoModulesCore
import Foundation
import MLKitFaceDetection

public struct ExpoMlkitFaceDetectorOptionsRecord: Record {

    public init() {}

    @Field
    var performanceMode: String = "fast"
    @Field
    var landmarkMode: Bool? = nil
    @Field
    var contourMode: Bool? = nil
    @Field
    var classificationMode: Bool? = nil
    @Field
    var minFaceSize: CGFloat? = nil
    @Field
    var isTrackingEnabled: Bool? = nil

}

public class ExpoMlkitFaceDetectorOptions {

    var performanceMode: FaceDetectorPerformanceMode = .fast
    var landmarkMode: FaceDetectorLandmarkMode = .none
    var contourMode:FaceDetectorContourMode = .none
    var classificationMode:FaceDetectorClassificationMode = .none
    var minFaceSize: CGFloat = 0.1
    var isTrackingEnabled:Bool = false


    init(performanceMode: FaceDetectorPerformanceMode?, landmarkMode: FaceDetectorLandmarkMode?, contourMode: FaceDetectorContourMode?, classificationMode: FaceDetectorClassificationMode?, minFaceSize: CGFloat?, isTrackingEnabled: Bool?) {
        self.performanceMode = performanceMode  ?? .fast
        self.landmarkMode = landmarkMode ?? .none
        self.contourMode = contourMode  ?? .none
        self.classificationMode = classificationMode  ?? .none
        self.minFaceSize = minFaceSize ?? 0.1
        self.isTrackingEnabled = isTrackingEnabled ?? false
    }

    convenience init(record: ExpoMlkitFaceDetectorOptionsRecord) {
        self.init(
            performanceMode: record.performanceMode == "accurate"
            ? FaceDetectorPerformanceMode.accurate
            : FaceDetectorPerformanceMode.fast,
            landmarkMode: record.landmarkMode == true
            ? FaceDetectorLandmarkMode.all
            : FaceDetectorLandmarkMode.none,
            contourMode: record.contourMode == true
            ? FaceDetectorContourMode.all
            : FaceDetectorContourMode.none,
            classificationMode: record.classificationMode == true
            ? FaceDetectorClassificationMode.all
            : FaceDetectorClassificationMode.none,
            minFaceSize: CGFloat(record.minFaceSize ?? 0.1),
            isTrackingEnabled: record.isTrackingEnabled)
    }

    var record: ExpoMlkitFaceDetectorOptionsRecord {
        let record = ExpoMlkitFaceDetectorOptionsRecord()
        record.performanceMode = self.performanceMode == .accurate ? "accurate" : "fast"
        record.landmarkMode = self.landmarkMode == .all
        record.contourMode = self.contourMode == .all
        record.classificationMode = self.classificationMode == .all
        record.minFaceSize = self.minFaceSize
        record.isTrackingEnabled = self.isTrackingEnabled
        return record
    }

    var options: FaceDetectorOptions {
        let options = FaceDetectorOptions()
        options.performanceMode = self.performanceMode
        options.landmarkMode = self.landmarkMode
        options.contourMode = self.contourMode
        options.classificationMode = self.classificationMode
        options.minFaceSize = self.minFaceSize
        options.isTrackingEnabled = self.isTrackingEnabled
        return options
    }
}
