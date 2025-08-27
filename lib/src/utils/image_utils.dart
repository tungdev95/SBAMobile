import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as IMG;
import 'dart:math' as math;

import 'package:path_provider/path_provider.dart';

const maxImageSize = 2160;
const imageFolder = "images";

Future<String> getImageDownloadFolder() async {
  var imageDownloadFolder =
      "${(await getApplicationDocumentsDirectory()).path}/$imageFolder";
  var downloadFolder = Directory(imageDownloadFolder);
  if (!(await downloadFolder.exists())) {
    debugPrint("Create folder: $imageDownloadFolder");
    await downloadFolder.create(recursive: true);
  }
  return imageDownloadFolder;
}

String getImageNameFromUrl(String url) {
  try {
    final lastPath = Uri.parse(url).pathSegments.last;
    final splitPath = lastPath.split(".");
    final lastStringType = splitPath.last;
    if (lastStringType.contains("jpg")) return "${splitPath.first}.jpg";
    if (lastStringType.contains("png")) return "${splitPath.first}.png";
    if (lastStringType.contains("gif")) return "${splitPath.first}.gif";
    if (lastStringType.contains("jpeg")) return "${splitPath.first}.jpeg";
    return lastPath;
  } catch (e) {
    print("Wrong image url");
    return "";
  }
}

Future<String> generateFullImagePathFromUrl(String url) async {
  return "${await getImageDownloadFolder()}/${getImageNameFromUrl(url)}";
}

Future<Uint8List> resizeImage(Uint8List data) async {
  Completer<Uint8List> completer = Completer();
  // Future.delayed(Duration(seconds: 3));
  compute(_resizeImage, data).then((value) => completer.complete(value));
  return completer.future;
}

Uint8List _resizeImage(Uint8List data) {
  try {
    Uint8List resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    if (img == null) return data;
    try {
      img = IMG.bakeOrientation(img);
    } catch (e) {
      debugPrint("bake orientation error: $e");
    }
    final bytes = data.lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;

    debugPrint("File size: $mb");

    var maxSize = math.max(img!.width, img.height);
    if (maxSize <= maxImageSize) return data;

    // debugPrint("Image size: ${img.width}x${img.height}");
    var newRatioSize = maxImageSize / maxSize;
    IMG.Image resized = IMG.copyResize(
      img,
      width: (img.width * newRatioSize).toInt(),
      height: (img.height * newRatioSize).toInt(),
    );
    resizedData = IMG.encodeJpg(resized);
    debugPrint(
        "File after resize: ${(resizedData.lengthInBytes / 1024) / 1024}");
    return resizedData;
  } catch (e) {
    debugPrint("Resize image error: $e");
    return data;
  }
}

Uint8List? bakeOrientation(Uint8List imageData) {
  IMG.Image? img = IMG.decodeImage(imageData);
  if (img == null) return imageData;
  try {
    var orientaionImage = IMG.bakeOrientation(img);
    return IMG.encodeJpg(orientaionImage, quality: 50);
  } catch (e) {
    return null;
  }
}

Future<bool> isImageDownloaded(String path) async {
  try {
    var imageDownloadFolder = await getImageDownloadFolder();
    var downloadFolder = Directory(imageDownloadFolder);
    if (!(await downloadFolder.exists())) {
      debugPrint("Create folder: $imageDownloadFolder");
      await downloadFolder.create(recursive: true);
    }
    if (await File(await generateFullImagePathFromUrl(path)).exists()) {
      return true;
    }
    return false;
  } catch (e) {
    print("file error: $e");
    return false;
  }
}
