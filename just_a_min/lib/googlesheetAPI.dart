import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApi {
  static const _credentials = {
    'type': 'service_account',
    'client_email': 'justminuteapp@justminuteapp.iam.gserviceaccount.com',
    'private_key':
        '''-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDm6YTWv+/7j2Ib\nXuMSxG/5bIotDs8JM4N3irQjL1wPgrRe3WeWK4CxXyYBURjQ4NR75ElGHMUA/tuQ\n4XXQDJsW6hiMEvrLYpVIkeGF39y2TZchs+q/gMpIhvkXfFhaSQbuFBWlR/PbyLf1\nm1/XXjFS+54CY4MGLNdzmpgadMx2kwwXisqqWFC0T5cWkPNp/AXETrY2ixhZiweu\nozYhDE1Qu9ZtHygL5197ljQq1j/yBSkGvnJY7/w1SnOLYfusiLaUoVEYfGRDWwii\nKCSUKVgZsMtHBGEcszYTmgt+bz+AC1L3DCseaovUjdE6cfyWrbrJDDoIN2vXD5cd\n6KC4ZqQlAgMBAAECggEAGFtvkLuEU/PG9H4o07T23seNN72FJ0JQzs5JvCBlxJkT\n76HJKHUESTFxL9hfFsFwiHUHKaclPLqlbH3r0HtT7LHazwO9grCucI46zMVVYcGD\nfKGe1H6AV/As3EZYh4WGfpyNv/Z8CaX9iaHPFUexSkCSZUwb6Q3X2DDpdHj3jFY5\nNqtKh2us3iKJdA9UrzxZER8OLkTfghmhKPSnCTzDk1pXMkp1MZjjTm40GGKuroJU\nc2PRb1cwd1X49s0h/3rHM/yb13xtVK2AYuZ7/ePPgcMZYMrEtZ3sac/EP5RYcyEf\no+e9ZDBiwPI165yoWTB+b7mYTyMf+AQMA16h5IWwDQKBgQD27Fmzzt4S8IcvlwqW\nsA4nnE4OYsOshhGW28cvSRnI2pbDgKORrviGohneSjyiMz52/B5isg19aNXiwgmW\niWhJypuNhztWs6q/RZtPEe1JM/bcjOp4M4/a3JncesD4AR6EJA8f2z3PMIpfMij+\nolfSgKdeg1ZSnnK9Fxbt4NUP6wKBgQDvZn9w5FuIBTPsKRnU8nmwLrzgXNTMQe9N\njD88It6s5VEohuFxjS6n/jPFW6CmVFi/+c2K4y+tLg36CfZEv7Rzy/3+XsUdXrOw\n7JuwDku1OPN5fRrHrdOzNkDgMrnefk+w5slMvK8XK7xi94/7s3+637RKCBEDenRW\ngv/eDWQoLwKBgQDTsgCZ6sJ0JGkSQQFf/aK1DQnSxZQTBoJv/w7/GEIV9GoLRO93\nSDZkXvekn6rqONrV8gMvBI4SNd4h4c+Mk1Oo6B6CsS0LgU/jWo7ztF/mQbnkjp+6\n3CH6NuVmpItqVLNQAQZCfpm4V1pakUuaO57lp01W92z7ukKOoQwUd4zTbwKBgQDB\nV0YVJlfFwm3sjEUQdcNRRm3DxTUWwSlCt8FaD89GUuz4jfYEfsDva5zkBtv3eKc0\nY8pcIJ6gflFLXkBFxY0298hpZqBK1/DHMk+KIAGEmjoII8E9AmW2llpOtqjlx50U\ngU6RatD9JZU/WDAwVwcRJRm1sE4NQRgzxhhefPImgQKBgQDuoiwQBN4BKpMCDrfP\ncnSwMn+UDbxBRLkg2ZjniTRJtH7kPKE7BVtYZjpQmaCDaIf4d2h84aiwpE3mTUuz\nuXmmMf6OcD8Eza5b7MtkvXFTVgpxiuEhnWQzm6skUihpkIT2CUahyVFIM8oQ02yw\nqCYesdCviW4iQBcDFy9OrnCZ0w==\n-----END PRIVATE KEY-----''',
    'client_id': '107131670912937230271',
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
        '$sheetName!A:F', 
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
