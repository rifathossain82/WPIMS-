import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wpims/utils/permissions.dart';
import 'package:flutter/material.dart';
import 'package:wpims/utils/snackbars.dart';

void downloadFile({required String url, required Function onComplete}) async {
  if (await checkStoragePermission()) {
    Response response;
    final extension = '.' + url.split('.').last;
    final fileName =
        'wpims' + DateTime.now().microsecondsSinceEpoch.toString() + extension;
    Directory directory = await getApplicationDocumentsDirectory();
    final filePath = File('${directory.path}/$fileName');
    try {
      response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = filePath.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      onComplete();
      OpenFile.open(filePath.path);
    } catch (e) {
      print(e);
    }
  }
}

void captureAndSave({
  required ScreenshotController controller,
  required Function onComplete
}) async {
  if (await checkStoragePermission()) {
    final Uint8List? ssImage = await controller.capture();
    Directory directory = await getTemporaryDirectory();
    final ssName =
        'wpims_ss_' + DateTime.now().microsecondsSinceEpoch.toString();
    final savePath = File('${directory.path}/$ssName.png');
    if (ssImage != null) {
      savePath.writeAsBytesSync(ssImage);
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(ssImage),
          quality: 100,
          name: ssName);
      if (result != null) {
        onComplete();
        shareFile(savePath.path, 'Shared from WPIMS');
      }
    }
  }
}

void shareFile(String path,String? message){
  Share.shareFiles([path], text: message??'');
}
