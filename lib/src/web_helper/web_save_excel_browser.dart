import 'dart:js_interop';
import 'package:web/web.dart';

// A wrapper to save the excel file in browser
class SavingHelper {
  static List<int>? saveFile(List<int>? val, String fileName) {
    if (val == null) return null;
    // Convert List<int> to JSArray<BlobPart>
    final blobParts = ([val] as dynamic) as JSArray<BlobPart>;
    final blob = Blob(
        blobParts,
        BlobPropertyBag(
            type:
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'));
    final url = URL.createObjectURL(blob);
    final anchor = HTMLAnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = fileName;
    document.body?.append(anchor);

    // download the file
    anchor.click();
    // cleanup
    anchor.remove();
    URL.revokeObjectURL(url);
    return val;
  }
}
