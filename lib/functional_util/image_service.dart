import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<XFile?> selectImage() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    return picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> selectImageFromGallery() async {
    final picker = ImagePicker();
    return picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 500,
      // <- reduce the image size
      maxWidth: 500,
    );
  }

  Future<XFile?> selectImageFromCamera() async {
    final picker = ImagePicker();
    return picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 500,
      // <- reduce the image size
      maxWidth: 500,
    );
  }
}
