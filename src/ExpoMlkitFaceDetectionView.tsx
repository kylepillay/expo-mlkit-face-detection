import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';

import { ExpoMlkitFaceDetectionViewProps } from './ExpoMlkitFaceDetection.types';

const NativeView: React.ComponentType<ExpoMlkitFaceDetectionViewProps> =
  requireNativeViewManager('ExpoMlkitFaceDetection');

export default function ExpoMlkitFaceDetectionView(props: ExpoMlkitFaceDetectionViewProps) {
  return <NativeView {...props} />;
}
