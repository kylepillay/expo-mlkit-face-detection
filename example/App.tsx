import * as ImagePicker from "expo-image-picker";
import * as ExpoMlkitFaceDetection from "expo-mlkit-face-detection";
import { useEffect, useState } from "react";
import { StyleSheet, Text, View, Button } from "react-native";

export default function App() {
  const faceDetector = ExpoMlkitFaceDetection.useFaceDetector();
  const [imageUri, setImageUri] = useState<string>();
  const [faceDetectorResult, setFaceDetectorResult] =
    useState<ExpoMlkitFaceDetection.ExpoMlkitFaceDetectionResult>();

  useEffect(() => {
    faceDetector.initialize({
      performanceMode: "fast",
    });
  }, []);

  useEffect(() => {
    (async () => {
      if (imageUri && imageUri.length > 0) {
        const result = await faceDetector.detectFaces(imageUri);
        setFaceDetectorResult(result);
      }
    })();
  }, [imageUri]);

  useEffect(() => {
    if (faceDetectorResult) {
      console.log(faceDetectorResult.faces.length);
    }
  }, [faceDetectorResult]);

  const pickImage = async () => {
    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [4, 3],
      quality: 1,
    });

    if (!result.canceled) {
      setImageUri(result.assets[0].uri);
    }
  };

  return (
    <View style={styles.container}>
      {imageUri ? (
        <Text>Selected Image URI: {imageUri}</Text>
      ) : (
        <Text>No Image Selected</Text>
      )}
      <Button title="Pick an image from gallery" onPress={pickImage} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});
