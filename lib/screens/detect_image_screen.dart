import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import '../utils/constants.dart';
import '../widgets/detection_result_card.dart';

class DetectImageScreen extends StatefulWidget {
  final String imagePath;

  const DetectImageScreen({super.key, required this.imagePath});

  @override
  State<DetectImageScreen> createState() => _DetectImageScreenState();
}

class _DetectImageScreenState extends State<DetectImageScreen> {
  bool _isLoading = true;
  List<YOLOResult> _results = [];
  String? _error;
  late YOLO _yolo;

  @override
  void initState() {
    super.initState();
    _initYOLOAndDetect();
  }

  Future<void> _initYOLOAndDetect() async {
    try {
      // Initialize YOLO model with useGpu: true for hardware acceleration
      _yolo = YOLO(
        modelPath: AppConstants.defaultModelId,
        task: YOLOTask.detect,
        useGpu: true,
      );
      await _yolo.loadModel();

      // Read image file as bytes
      final file = File(widget.imagePath);
      final Uint8List imageBytes = await file.readAsBytes();

      // Run inference
      final Map<String, dynamic> resultsMap = await _yolo.predict(imageBytes);
      final List<dynamic> detections = resultsMap['detections'] as List<dynamic>? ?? [];
      final results = detections.map((d) => YOLOResult.fromMap(d as Map<dynamic, dynamic>)).toList();

      if (mounted) {
        setState(() {
          _results = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
      ),
      body: Column(
        children: [
          // Display the selected image
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.black12,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Display results or loading state
          Expanded(
            flex: 3,
            child: _buildResultsSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Running YOLO detection...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error: $_error',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_results.isEmpty) {
      return const Center(
        child: Text(
          'No objects detected.',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Found ${_results.length} objects',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _results.length,
            itemBuilder: (context, index) {
              final result = _results[index];
              return DetectionResultCard(
                className: result.className,
                confidence: result.confidence,
              );
            },
          ),
        ),
      ],
    );
  }
}
