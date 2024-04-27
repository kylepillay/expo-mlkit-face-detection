import * as React from 'react';

import { ExpoMlkitFaceDetectionViewProps } from './ExpoMlkitFaceDetection.types';

export default function ExpoMlkitFaceDetectionView(props: ExpoMlkitFaceDetectionViewProps) {
  return (
    <div>
      <span>{props.name}</span>
    </div>
  );
}
