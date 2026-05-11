import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  /// Requests camera permission and returns true if granted.
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    
    if (status.isGranted) {
      return true;
    }
    
    if (status.isPermanentlyDenied) {
      // Guide user to settings if permanently denied
      await openAppSettings();
    }
    
    return false;
  }
}
