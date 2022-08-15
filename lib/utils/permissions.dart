import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

Future<bool> checkStoragePermission() async {
  if (Platform.isAndroid) {
    return await requestPermission(Permission.storage);
  } else {
    return await requestPermission(Permission.photos);
  }
}
