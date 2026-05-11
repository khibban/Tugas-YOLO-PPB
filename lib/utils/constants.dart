import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4CAF50);
  static const secondary = Color(0xFF2196F3);
  static const background = Color(0xFFF5F5F5);
  static const text = Color(0xFF333333);
}

class AppConstants {
  // Using yolo11n because yolo26n has an incompatible tensor shape (1, 300, 6)
  static const String defaultModelId = 'assets/models/yolo11n.tflite';
}
