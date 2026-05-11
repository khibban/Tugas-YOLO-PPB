Place your custom YOLO .tflite model files here.

By default, the app uses the official 'yolo26n' model which is
automatically downloaded and cached by the ultralytics_yolo plugin.

To use a custom model:
1. Export your YOLO model: yolo export model=best.pt format=tflite
2. Copy the .tflite file into this folder
3. Update constants.dart with the new model path
