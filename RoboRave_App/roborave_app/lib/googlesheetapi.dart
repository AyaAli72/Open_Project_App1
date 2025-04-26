import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApi {
  static Future<SheetsApi> _getSheetsApi() async {
    final credentials = ServiceAccountCredentials.fromJson({
      'type': 'service_account',
      'client_email': dotenv.env['GOOGLE_SHEETS_CLIENT_EMAIL'],
      'private_key': dotenv.env['GOOGLE_SHEETS_PRIVATE_KEY']?.replaceAll('\\n', '\n'),
      'client_id': dotenv.env['GOOGLE_SHEETS_CLIENT_ID'],
    });

    final client = await clientViaServiceAccount(
      credentials,
      [SheetsApi.spreadsheetsReadonlyScope],
    );
    return SheetsApi(client);
  }

  static Future<List<List<String>>> getSheetData(String spreadsheetId, String range) async {
    try {
      final sheets = await _getSheetsApi();
      final response = await sheets.spreadsheets.values.get(spreadsheetId, range);
      return response.values?.map((row) => row.map((cell) => cell.toString()).toList()).toList() ?? [];
    } catch (e) {
      throw Exception('Failed to fetch sheet data: $e');
    }
  }

  static ({String spreadsheetId, String? sheetId}) parseUrl(String url) {
    final uri = Uri.parse(url);
    final path = uri.pathSegments;
    final fragment = uri.fragment;

    return (
      spreadsheetId: path.length > 2 ? path[2] : '',
      sheetId: fragment.contains('gid=') ? fragment.split('gid=')[1] : null,
    );
  }
}