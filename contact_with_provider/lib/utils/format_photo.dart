import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class FormatPhoto with ChangeNotifier{

  MemoryImage imageFromBase64String(String base64String) {
    //notifyListeners();
    return MemoryImage(
      base64Decode(base64String),
    );
  }

  String base64String(Uint8List data) {
    notifyListeners();
    return base64Encode(data);
  }

}