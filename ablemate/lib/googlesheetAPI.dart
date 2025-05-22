import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApi {
  static const _credentials = {
    'type': 'service_account',
    'client_email': 'appsigninsheet@ablematapp.iam.gserviceaccount.com',
    'private_key':
        '''-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDJOVHO1u10tCsm\nkvpExrIi1bk0cygPfwzcuzLjFJ6Gw1WNQl92qoOHQ+vBIhxeS7lOglx3Zf076A4U\nmFJjWMFWSrDtbRyfYttjBqJtLF5D542CuMDw13v73uSJDuVRzeLgGcYEd+SOAv2L\nmqLCp78DIOm+KtdUpB7jT8Y+uFkEfJk8vWzz4zJ6TIIrX468scUklOVp1vZVIXCa\nh2xQrnf1Bi+YiS+BSZGKdut9i68LVbNQSd0/uUlL1blP6vMyreRM9lH+TCemVPPU\nwVsER8PHzEaQiaNYgGBevzSJOyTUVtLLQaPcvzPbofU5Qr7EW7W1J1ty12qzZCi8\nLgJc6k4hAgMBAAECggEAPM3sygdJNrAwr9XO+VRfRMZ3UgGQM+qM3PBWRqcW5hsF\ncYuCZE3PM+MSzMf9cYMJSk97GHtBo8YR5yhGEQ4jUet8/imv8fvB1nENSNcU3wkL\nyloAt2Yt6WSng0D0i50etuAi5XvDHSSLMBG4qABfaFccOqIgckurp72V5qL3BzME\nGXxQTXM2FcVU7eOWQJ6GcRMpzN30oZ9NX685FJC8dRgaOiXdpvlCOpzD0Y3wN6aL\nTLXcEN0IGz6fHjpHcoGiFCvFomLa66joydE3hmb7pUYGo+wm+OlACMzu0CJk/6Ww\nwaeRwknrGAeShwIsHOLPildZ0R3LfTu9YyPV0C6yzwKBgQDuJaLLN8u7NhniKJ0h\nfcHVIwvM8P1FMEuBjEGXg4hhE1x2/B+7iEve/deTH5K6LD+6eFJcir3b2N1K0aHP\nWK8yqYMuYWj0Q+lrpdf9SQcavc5c4J0fJyZVeDa/JGkgNs7eQ0nXvppNu78f4NJV\nDcLLmfq3azlN0feCTAWwCzHILwKBgQDYTxQ/on1S49jtrGMxD75ePWE3ptDEEWno\nyUyqjVs7ZWHHNxu0w83R1ZbJ1GtZvwYCAW2Zr35NC0K0nIEAeRzGIVxZ78GXzsbD\n1qVaTDw+v/aO+PvKftik2Pxn6PvB80KzMzUzpUFDJeHOEQcZ/DXSzaIUn9nhJP2t\nO5mRuDFqrwKBgD8X44h5kNVZoQPlBLRB0B+6uD6kvkUdZXO+CAavR2uIqJ+xbmrN\n0mQS1pFY9ROz83JgvFlePKzJSN+wqHD5qvj+Jg4cqqTEdUwa1R16wpIYJVs/+wCs\n66ALSF3dtKhfPPFv3Fl3WwQrMJiuhKsaCTjN47nCg50VesCfiYY5gQfrAoGAZJni\nwPXBc5ukeGWEfHzl/M5vOILM9WNj7nAwx+GWXLl6ED0BFcE7KCw+RQAWLVc6ZBRl\n9OQ5yXtDOtzO4nlxeHRrjyiC0SfKKaranHR4UHbXJQeHk1YLTB/exDUHYdzRWKao\nR6zD/YbQzhX9R4iVP8WDbDQsERozIS5m7e7MjOECgYEAgrrWiVOgJd8l/+WCikZy\njEqT9Mqu1kvyvPc6FxkBTliwT6vwSV41IXiYhkBXLBSdlfA3fjdZMwooe8VaFjO1\nE5ztETn0F1Ij1n/XXg7/it+HhZG2oou7OteDOEbnNLRXmfAVFKaNiE7E3Z+qD9W4\nToR7nob75h2pmzye+VRhVGc=\n-----END PRIVATE KEY-----''',
    'client_id': '100931256144079421244',
  };

  static Future<SheetsApi> _getSheetsApi() async {
    final credentials = ServiceAccountCredentials.fromJson(_credentials);

    final client = await clientViaServiceAccount(
      credentials,
      [SheetsApi.spreadsheetsScope],
    );

    return SheetsApi(client);
  }

  // Append data to the next available row in a sheet
  static Future<void> appendRow({
    required String spreadsheetId,
    required String sheetName,
    required List<dynamic> rowData,
  }) async {
    try {
      final sheets = await _getSheetsApi();

      final valueRange = ValueRange()..values = [rowData];

      await sheets.spreadsheets.values.append(
        valueRange,
        spreadsheetId,
        '$sheetName!A:D', // Append to any column in the sheet
        valueInputOption: 'USER_ENTERED',
        insertDataOption: 'INSERT_ROWS',
      );
    } catch (e) {
      throw Exception('Failed to append data: $e');
    }
  }

  // Update specific cells in the sheet
  static Future<void> updateRow({
    required String spreadsheetId,
    required String range, // e.g., 'Sheet1!A2:D2'
    required List<dynamic> rowData,
  }) async {
    try {
      final sheets = await _getSheetsApi();

      final valueRange = ValueRange()..values = [rowData];

      await sheets.spreadsheets.values.update(
        valueRange,
        spreadsheetId,
        range,
        valueInputOption: 'USER_ENTERED',
      );
    } catch (e) {
      throw Exception('Failed to update row: $e');
    }
  }

  // Get data from a range
  static Future<List<List<String>>> getData({
    required String spreadsheetId,
    required String range,
  }) async {
    try {
      final sheets = await _getSheetsApi();
      final response = await sheets.spreadsheets.values.get(
        spreadsheetId,
        range,
      );

      return response.values
              ?.map((row) => row.map((cell) => cell.toString()).toList())
              .toList() ??
          [];
    } catch (e) {
      throw Exception('Failed to fetch sheet data: $e');
    }
  }
}
