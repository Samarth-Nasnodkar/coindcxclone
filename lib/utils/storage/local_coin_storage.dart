import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class LocalCoinStorage {
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();

    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final file = File("$path/coinStore.json");
    return file;
  }

  Future<Map<String, dynamic>?> storage() async {
    try {
      final file = await _localFile;

      String _data = file.readAsStringSync();
      return jsonDecode(_data);
    } catch (e) {
      return null;
    }
  }

  Future<Map<dynamic, dynamic>?> fetchCoins() async {
    String endpoint = "/api/v2/assets";
    final res = await http.get(Uri.https("data.messari.io", endpoint, {
      "fields": "id,slug,symbol",
      // "limit": 30,
    }));
    if (res.statusCode == 200) {
      final _jdata = jsonDecode(res.body);
      return _jdata;
    } else {
      return null;
    }
  }

  dumpFromNet() async {
    final data = await fetchCoins();
    final file = await _localFile;
    file.writeAsString(jsonEncode(data));
  }
}
