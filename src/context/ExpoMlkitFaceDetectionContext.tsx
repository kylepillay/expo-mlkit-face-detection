import { createContext, PropsWithChildren, FC } from "react";

import { ExpoMlkitFaceDetector } from "../module/ExpoMlkitFaceDetector";
import { ExpoMlkitFaceDetectorOptions } from "../types";

export type ReactMLKitFaceDetectionContextValue = {
  faceDetector: ExpoMlkitFaceDetector;
};

export const ReactMLKitFaceDetectionContext =
  createContext<ReactMLKitFaceDetectionContextValue>({
    faceDetector: new ExpoMlkitFaceDetector(),
  });

export const ExpoMlkitFaceDetectionContextProvider: FC<
  PropsWithChildren<{
    options?: ExpoMlkitFaceDetectorOptions;
    deferInitialization?: boolean;
  }>
> = ({ options, deferInitialization, children }) => {
  const contextValue: ReactMLKitFaceDetectionContextValue = {
    faceDetector: new ExpoMlkitFaceDetector(options, deferInitialization),
  };

  return (
    <ReactMLKitFaceDetectionContext.Provider value={contextValue}>
      {children}
    </ReactMLKitFaceDetectionContext.Provider>
  );
};
