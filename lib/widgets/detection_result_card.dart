import 'package:flutter/material.dart';

class DetectionResultCard extends StatelessWidget {
  final String className;
  final double confidence;

  const DetectionResultCard({
    super.key,
    required this.className,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    // Convert confidence to a percentage (e.g., 0.85 -> 85%)
    final confidencePercent = (confidence * 100).toStringAsFixed(1);
    
    // Choose a color based on confidence level
    Color confidenceColor;
    if (confidence > 0.8) {
      confidenceColor = Colors.green;
    } else if (confidence > 0.5) {
      confidenceColor = Colors.orange;
    } else {
      confidenceColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: confidenceColor.withValues(alpha: 0.2),
          child: Icon(
            Icons.center_focus_weak,
            color: confidenceColor,
          ),
        ),
        title: Text(
          className.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Confidence: $confidencePercent%'),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: confidence,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(confidenceColor),
            ),
          ],
        ),
      ),
    );
  }
}
