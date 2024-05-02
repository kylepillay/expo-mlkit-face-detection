// Import the native module. On web, it will be resolved to ExpoMlkitFaceDetection.web.ts
// and on native platforms to ExpoMlkitFaceDetection.ts

export * from "./context/ExpoMlkitFaceDetectionContext";
export * from "./module/ExpoMlkitFaceDetector";
export * from "./types";
export * from "./hooks/useFacesInPhoto";
export { useFaceDetector } from "./hooks/useFaceDetector";
