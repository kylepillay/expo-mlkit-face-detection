import { NativeModulesProxy, EventEmitter, Subscription } from 'expo-modules-core';

// Import the native module. On web, it will be resolved to ExpoMlkitFaceDetection.web.ts
// and on native platforms to ExpoMlkitFaceDetection.ts
import ExpoMlkitFaceDetectionModule from './ExpoMlkitFaceDetectionModule';
import ExpoMlkitFaceDetectionView from './ExpoMlkitFaceDetectionView';
import { ChangeEventPayload, ExpoMlkitFaceDetectionViewProps } from './ExpoMlkitFaceDetection.types';

// Get the native constant value.
export const PI = ExpoMlkitFaceDetectionModule.PI;

export function hello(): string {
  return ExpoMlkitFaceDetectionModule.hello();
}

export async function setValueAsync(value: string) {
  return await ExpoMlkitFaceDetectionModule.setValueAsync(value);
}

const emitter = new EventEmitter(ExpoMlkitFaceDetectionModule ?? NativeModulesProxy.ExpoMlkitFaceDetection);

export function addChangeListener(listener: (event: ChangeEventPayload) => void): Subscription {
  return emitter.addListener<ChangeEventPayload>('onChange', listener);
}

export { ExpoMlkitFaceDetectionView, ExpoMlkitFaceDetectionViewProps, ChangeEventPayload };
