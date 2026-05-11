import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import '../utils/constants.dart';

class LiveDetectScreen extends StatefulWidget {
  const LiveDetectScreen({super.key});

  @override
  State<LiveDetectScreen> createState() => _LiveDetectScreenState();
}

class _LiveDetectScreenState extends State<LiveDetectScreen> {
  final YOLOViewController _controller = YOLOViewController();
  int _objectCount = 0;

  @override
  void dispose() {
    // Controller is disposed automatically by YOLOView, but if we need to clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Detection'),
      ),
      body: Stack(
        children: [
          // The YOLOView handles the camera feed and bounding boxes automatically
          YOLOView(
            modelPath: AppConstants.defaultModelId,
            task: YOLOTask.detect,
            confidenceThreshold: 0.5, // Filter out low-confidence flickering noise
            useGpu: true, // Re-enable GPU now that we use a stable local TFLite file
            controller: _controller,
            onResult: (results) {
              if (mounted) {
                setState(() {
                  _objectCount = results.length;
                });
              }
            },
          ),
          
          // Overlay to show current count
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Detected Objects: $_objectCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
