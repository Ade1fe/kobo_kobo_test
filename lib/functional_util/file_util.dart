import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileUtil {
  Future<File?> selectFile([
    List<String> allowedExtensions = const ['jpg', 'pdf', 'doc', 'png'],
  ]) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      final file = File(result.files.single.path!);

      return file;
    }

    return null;
  }

  static Future<String> getUniqueFilePath({
    required String fileExtension,
    String? fileName,
  }) async {
    assert(
      !fileExtension.startsWith('.'),
      "Remove '.' from file extension",
    );

    final dirPath = await getTemporaryDirectory();

    final random = DateTime.now().microsecondsSinceEpoch;

    final fullFileName = '${fileName ?? ''}$random.$fileExtension'.trim();

    final tempDir = path.join(dirPath.path, fullFileName);

    return tempDir;
  }

  static Future<void> shareFile(String filePath) async {
    final fileName = _getFileBaseName(filePath);
    await Share.shareXFiles([XFile(filePath)], text: '$fileName receipt');
  }

  static String _getFileBaseName(String filePath) {
    return path.basename(filePath);
  }
}
