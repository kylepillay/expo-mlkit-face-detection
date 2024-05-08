import ExpoMlkitFaceDetectionModule from "./ExpoMlkitFaceDetectionModule";
import {
  ExpoMlkitFaceDetectorOptions,
  ExpoMlkitFaceDetectionResult,
} from "../types";

async function initialize(options?: ExpoMlkitFaceDetectorOptions) {
  return await ExpoMlkitFaceDetectionModule.initialize(options);
}

async function detectFaces(imageUri: string) {
  return await ExpoMlkitFaceDetectionModule.detectFaces(imageUri);
}

export type FaceDetectionState =
  | "init"
  | "modelLoading"
  | "ready"
  | "detecting"
  | "done"
  | "error";

const DEFAULT_OPTIONS: ExpoMlkitFaceDetectorOptions = {
  performanceMode: "fast",
};

export class ExpoMlkitFaceDetector {
  public status: FaceDetectionState = "init";
  public error: string | undefined = undefined;
  private options: ExpoMlkitFaceDetectorOptions;

  constructor(options = DEFAULT_OPTIONS, deferInitialization?: boolean) {
    this.options = options;
    if (deferInitialization) {
      return;
    }
    this.initialize(options);
  }

  async detectFaces(imageUri: string) {
    this.status = "detecting";
    try {
      const result = await ExpoMlkitFaceDetectionModule.detectFaces(imageUri);
      this.status = "done";
      return result as ExpoMlkitFaceDetectionResult;
    } catch (e: unknown) {
      this.status = "error";
      console.error(
        e instanceof Error
          ? e.message
          : "An unknown error occurred while detecting faces",
      );
      return undefined;
    }
  }

  async initialize(options?: ExpoMlkitFaceDetectorOptions) {
    try {
      if (options) {
        this.options = options;
      }
      this.status = "modelLoading";
      await ExpoMlkitFaceDetectionModule.initialize(this.options);
      this.status = "ready";
    } catch (e: unknown) {
      this.status = "error";
      console.error(
        e instanceof Error
          ? e.message
          : "An unknown error occurred while initializing the model",
      );
    }
  }
}
