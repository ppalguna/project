

//import 'dart:ffi';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source, int imageQuality) async{
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source, imageQuality: imageQuality);
  
  if(file != null){
    return await file.readAsBytes();
  }
print("Tidak ada gambar dipilih ");
}

// compress file and get Uint8List
  