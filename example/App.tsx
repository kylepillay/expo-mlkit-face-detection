import { StyleSheet, Text, View } from 'react-native';

import * as ExpoMlkitFaceDetection from 'expo-mlkit-face-detection';

export default function App() {
  return (
    <View style={styles.container}>
      <Text>{ExpoMlkitFaceDetection.hello()}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
