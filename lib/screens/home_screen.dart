import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/permissions_helper.dart';
import 'detect_image_screen.dart';
import 'live_detect_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openImagePicker(BuildContext context, ImageSource source) async {
    if (source == ImageSource.camera) {
      final granted = await PermissionsHelper.requestCameraPermission();
      if (!granted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Camera permission is required.')),
          );
        }
        return;
      }
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetectImageScreen(imagePath: pickedFile.path),
        ),
      );
    }
  }

  void _openLiveCamera(BuildContext context) async {
    final granted = await PermissionsHelper.requestCameraPermission();
    if (!granted) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera permission is required.')),
        );
      }
      return;
    }

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LiveDetectScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOLO Object Detection'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.center_focus_strong,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 32),
              const Text(
                'Detect Objects with YOLO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              _buildActionButton(
                icon: Icons.photo_library,
                label: 'Pick from Gallery',
                onPressed: () => _openImagePicker(context, ImageSource.gallery),
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                icon: Icons.camera_alt,
                label: 'Take a Photo',
                onPressed: () => _openImagePicker(context, ImageSource.camera),
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                icon: Icons.videocam,
                label: 'Live Detection',
                isPrimary: true,
                onPressed: () => _openLiveCamera(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: isPrimary ? Colors.green.shade700 : Colors.green,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
