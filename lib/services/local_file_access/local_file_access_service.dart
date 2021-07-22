import 'dart:io';
import 'package:aswanna_application/exception/local_file/image_pick_exeption_handling.dart';
import 'package:aswanna_application/exception/local_file/local_file_exeption_handling.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

Future<String> choseImageFromLocalFiles(
  BuildContext context, {
  int maxSizeInKB = 1024,
  int minSizeInKB = 5,
}) async {
  final PermissionStatus photoPermissionStatus =
      await Permission.photos.request();
  if (!photoPermissionStatus.isGranted) {
    throw LocalFileHandlingStorageReadPermissionDeniedException(
        message: "Permission required to read storage, please give permission");
  }

  final imgPicker = ImagePicker();
  final imgSource = await showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text("Chose image source"),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context, ImageSource.camera),
              child: Text("Camera")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: Text("Gallery")),
        ],
      );
    },
    context: context,
  );
  if (imgSource == null)
    throw LocalImagePickingInvalidImageException(
        message: "No image source selected");
  final PickedFile imagePicked = await imgPicker.getImage(source: imgSource);
  if (imagePicked == null) {
    throw LocalImagePickingInvalidImageException();
  } else {
    final fileLength = await File(imagePicked.path).length();
    if (fileLength > (maxSizeInKB * 1024) ||
        fileLength < (minSizeInKB * 1024)) {
      throw LocalImagePickingFileSizeOutOfBoundsException(
          message: "Image size should not exceed 1MB");
    } else {
      return imagePicked.path;
    }
  }
}
