import Foundation
import ExpoModulesCore
import MLKitFaceDetection
import MLKitVision


// Record struct to hold the raw data
struct ExpoMlkitFaceDetectionResultRecord: Record {
    @Field
    var faces: [ExpoMlkitFace] = []
    @Field
    var imagePath: String
}

// Class to provide getter for the record and easy manipulation
public class ExpoMlkitFaceDetectionResult {
    var faces: [Face]
    var imagePath: String

    init(faces: [Face], imagePath: String) {
        self.faces = faces
        self.imagePath = imagePath
    }

    var record: ExpoMlkitFaceDetectionResultRecord {
        let logger = Logger()
        let record = ExpoMlkitFaceDetectionResultRecord()
        let faces = self.faces.map { face in
            let expoFace = ExpoMlkitFace()
            expoFace.smilingProbability = face.smilingProbability
            expoFace.rightEyeOpenProbability = face.rightEyeOpenProbability
            expoFace.leftEyeOpenProbability = face.leftEyeOpenProbability
            expoFace.headEulerAngleX = CGFloat(face.headEulerAngleX)
            expoFace.headEulerAngleY = CGFloat(face.headEulerAngleY)
            expoFace.headEulerAngleZ = CGFloat(face.headEulerAngleZ)
            expoFace.trackingID = face.trackingID
            
            
            expoFace.frame = ExpoMlkitRect.fromCGRect(rect: face.frame)

            for landmark in face.landmarks {
                let expoLandmark = ExpoMlkitFaceLandmark()
                expoLandmark.type = landmark.type.rawValue
                expoLandmark.position = ExpoMlkitPoint.fromVisionPoint(p: landmark.position)
                expoFace.landmarks.append(expoLandmark)
            }

            // Assuming 'contours' is an array of FaceContour objects
            for contour in face.contours {
                let expoContour = ExpoMlkitFaceContour()
                expoContour.type = contour.type.rawValue
                expoContour.points = contour.points.map(ExpoMlkitPoint.fromVisionPoint)
                expoFace.contours.append(expoContour)
            }

            return expoFace}
        
        record.faces = faces;
        record.imagePath = self.imagePath
        return record
    }
}


struct ExpoMlkitFace: Record {
    @Field
    var frame: ExpoMlkitRect = ExpoMlkitRect()
    @Field
    var landmarks: [ExpoMlkitFaceLandmark] = []
    @Field
    var contours: [ExpoMlkitFaceContour] = []
    @Field
    var trackingID: Int? = nil
    @Field
    var headEulerAngleX: CGFloat? = nil
    @Field
    var headEulerAngleY: CGFloat? = nil
    @Field
    var headEulerAngleZ: CGFloat? = nil
    @Field
    var smilingProbability: CGFloat? = nil
    @Field
    var leftEyeOpenProbability: CGFloat? = nil
    @Field
    var rightEyeOpenProbability: CGFloat? = nil
}

struct ExpoMlkitFaceLandmark: Record {
    
    @Field
    var type: String = ""  // Use Enum to represent FaceLandmarkType
    
    @Field
    var position: ExpoMlkitPoint = ExpoMlkitPoint()
    
}

struct ExpoMlkitFaceContour:Record {
    @Field
    var type: String = ""
    @Field
    var points: [ExpoMlkitPoint] = []
}

struct ExpoMlkitPoint:Record {
    @Field
    var x: CGFloat = 0
    @Field
    var y: CGFloat = 0
    
    static func fromVisionPoint(p:VisionPoint) -> ExpoMlkitPoint {
        let point = ExpoMlkitPoint()
        point.x = p.x
        point.y = p.y
        return point}
}

struct ExpoMlkitRect: Record {
    @Field
    var origin: ExpoMlkitPoint
    @Field
    var size: ExpoMlkitPoint

    static func fromCGRect(rect: CGRect) -> ExpoMlkitRect {
        var expoRect = ExpoMlkitRect()

        var origin = ExpoMlkitPoint()
        origin.x = rect.origin.x
        origin.y = rect.origin.y
        
        var size = ExpoMlkitPoint()
        size.x = rect.width
        size.y = rect.height
        
        expoRect.origin = origin;
        expoRect.size = size
        
        return expoRect
    }
}
