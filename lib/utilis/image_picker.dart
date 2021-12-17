import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickFile {
  Future<File?> getImage() async {
    File file;

    ImagePicker filePicker = ImagePicker();

    final pickedFile = await filePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 500);

    if (pickedFile != null) {
      file = File(pickedFile.path);
      return file;
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<File?> pickAVideo() async {
    File file;

    ImagePicker filePicker = ImagePicker();

    final pickedFile = await filePicker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      print(pickedFile.path);
      file = File(pickedFile.path);
      return file;
    } else {
      print('No Video selected.');
      return null;
    }
  }
}
