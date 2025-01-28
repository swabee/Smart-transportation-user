import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/constant/app_constant.dart';


enum ImageSourceOption { camera, gallery }

Future<File?> getImage(ImageSourceOption sourceOption) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: sourceOption == ImageSourceOption.camera
        ? ImageSource.camera
        : ImageSource.gallery,
  );

  if (pickedFile != null) {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      //     aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9
      // ]
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          // toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
    if (croppedFile == null) {
      return null;
    }

    return File(croppedFile.path);
  }

  return null;
}

Future<File?> getVideo(ImageSourceOption sourceOption) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickVideo(
    source: sourceOption == ImageSourceOption.camera
        ? ImageSource.camera
        : ImageSource.gallery,
  );

  if (pickedFile != null) {
    return File(pickedFile.path);
  }

  return null;
}
