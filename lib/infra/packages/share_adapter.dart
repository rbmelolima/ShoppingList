import 'package:share_plus/share_plus.dart';

class ShareAdapter {
  Future<void> share(String content) async {
    await Share.share(content);
  }
}
