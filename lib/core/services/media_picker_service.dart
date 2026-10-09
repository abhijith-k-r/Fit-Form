import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> pickImage() async {
  try {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (pickedFile == null) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName =
        'img_${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';
    final savedFile =
        await File(pickedFile.path).copy('${appDir.path}/$fileName');
    return savedFile.path;
  } catch (e) {
    return null;
  }
}

Future<String?> pickVideo() async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName =
        'vid_${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';
    final savedFile =
        await File(pickedFile.path).copy('${appDir.path}/$fileName');
    return savedFile.path;
  } catch (e) {
    return null;
  }
}
