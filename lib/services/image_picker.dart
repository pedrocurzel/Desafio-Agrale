import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker picker = ImagePicker();

  Future<File?> getImage({required ImageSource source}) async {
    XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}