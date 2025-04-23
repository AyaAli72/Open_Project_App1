import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApiData {
  final String url;
  final String clientId;
  final String clientEmail;
  final String privateKey;

  String? spreadsheetId;
  String? gid;

  GoogleSheetsApiData({
    required this.clientEmail,
    required this.clientId,
    required this.privateKey,
    required this.url,
  });

  void extractGidAndIdFromUrl(String url) {
    Uri uri = Uri.parse(url);

    // Extract spreadsheet ID from the URL path
    List<String> pathSegments = uri.pathSegments;
    if (pathSegments.length > 2) {
      spreadsheetId = pathSegments[2];
    }

    // Extract gid from the URL fragment
    String fragment = uri.fragment;
    if (fragment.contains("gid=")) {
      gid = fragment.split("gid=")[1];
    }
  }

  Future<dynamic> accessGoogleSheetData() async {
    // Extract spreadsheetId and gid
    extractGidAndIdFromUrl(url);

    if (spreadsheetId == null || gid == null) {
      throw Exception("Invalid spreadsheet URL.");
    }

    // Define credentials
    final credentials = ServiceAccountCredentials.fromJson({
      'type': 'service_account',
      'client_email':
          "roborave-app-sheet@custom-healer-457718-a5.iam.gserviceaccount.com",
      'private_key':
          '\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrD3yisNQ8I1td\nRI8OJ0hyHjpZFbwVPcyFlZKnpqW0YRGKa/yenWcjTKJSSpRgl7Nruo27O6Jw+14I\nZUWbvUEW2iy8vfqBRdyPH+JBn3yxFKaiw5EPw3QWBP2cbxzNHlbCAO/lW9hKXvjY\ns6SajHhTFuR+Lvf/Wfbj+Tj0mnZ//YqRHgvex5DwtxYgiDvqffv0wylW+wcbVJgc\neBQwOBc7EBVjhCvAMO+b32B70XP6ssZiMPedY86xIqZX4B94iGBSuTJEG/B76qFv\n/rSrr1puqruHoSp0Y+NUjFEEcIW9ICuD8+dQYuyn6jga9Y/86e3C4ZTujj5yXMmf\nAFTKSETfAgMBAAECggEAFYdFcFRA4bCxdvOB7Y4UGAil30BVA3dbnhRM+LyIbkMp\nKfqdOHkm2dJzO1gXhHCTLCO2YrIGp6F7HCNit08COhYLO1XNiSd5sqmYmBmyX7bx\nodprD0jR+1N1d5KkVUxULuZfSsZcWj/Jobw6Ixk6q3peF2Nh4sk3wUlEWcR21XSm\nKpsPetqmYW5D7pcLh+sG4IR06XbK+nqABi8x12yOoU7A0BZE43AJJ4PEcCDWitu0\n719YrHTYH9ntMsbb2UT7sslRNvohwJ36TjXvsRJB9ARgUhjwV1/AiWNRm4A0Cxjb\nmFnyl8UeV673qdbhi2VBygSSE3yjXRT0xHDrYdhkAQKBgQDvurlvUwIYEqIVQmZ0\nKmyRvMoFSwBwlOxnobVUZF8F28mVdoJwk8yzgKf7m0167EPVO9gHYgL3+5k2ZnmH\nNjyWFmhzpsyQlzpOvsCZlioCd+R3gbq8YifjmNeJcQplQ2gi6wc1qO3iLAN5xT9k\nAeZg8Tlu6s0069JFkNBpiWi5HwKBgQC2q6WaIK/U3HKyAUxsKKXv8ZmfxBq6vN0P\n7j7mU3iJ3X6M36B9ipf8zZfccB51V11RpNlPNrzRGcmXRvByBDHP9Cbn0tbs2Aig\nxxXyJRp6x6YZnFUY5MrGlpbj6z3qfcm0Iw6eutVw4kkXc04HKTxAHbA3JVCXgFLW\nsmMTJPI8QQKBgQCJ3B93XYz+uvhqsVypwRveU2r50D/YfkvU7LGSboYWoGY0hYpN\nozE8qOfxUUYlQmlf3qJE3KBIa2+YUSXiE9aTmR9IIsvQ+qaVUi0AJdLSyI+iCgCR\nBQFbaTHJ4C/SPAlOy0nCGfty7UyyYjQqFs2dQht9JZoMrPCnALhZeKO4kQKBgFeD\n6LTs0BClBPYvFRQEbWuFTlpys3OfpDFLrSrf9rHmQgjv4o4C5kohnY3o0U7aakUB\nO3NuAAwV1LT7MZsOU2cTy8fpBTs3TPrqJqN6DzOfjv5aHZLtmhCGeQf83g8H8Kiy\n2wBE9pk8cFQh09IueUUmdBQXdoL+4bEmibzUSJGBAoGAYmWoyubwxtk9ZenNlzca\nrVJLNWvGqC0dIcgGWgUnkl4yfhldOcXNV25/aO2q8nM0FapIAN7CSlSNccW9kqMt\nTYH7EmrUbei3PW4Y2kadG11gIFfyz1iv+Hpa2qFdlbSP2g7xuQvWnGC3JO5Wo7kh\nkHvh5tq5esK4d9hhEk8z4hQ=\n',
    });

    // Authenticate
    final client = await clientViaServiceAccount(
      credentials,
      [SheetsApi.spreadsheetsReadonlyScope],
    );

    try {
      final sheets = SheetsApi(client);

      // Get spreadsheet info
      var spreadsheet = await sheets.spreadsheets.get(spreadsheetId!);

      // Find the sheet by gid (sheetId)
      Sheet? sheet = spreadsheet.sheets?.firstWhere(
        (s) => s.properties?.sheetId.toString() == gid,
        orElse: () => throw Exception("Sheet with GID $gid not found."),
      );

      // Get sheet title to use in range
      String range = sheet?.properties?.title ?? '';
      if (range.isEmpty) throw Exception("Sheet title is empty.");

      // Fetch the sheet values
      var response =
          await sheets.spreadsheets.values.get(spreadsheetId!, range);
      return response;
    } finally {
      client.close();
    }
  }
}
