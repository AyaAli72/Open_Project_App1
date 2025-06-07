import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApi {
  static const _credentials = {
    'type': 'service_account',
    'client_email': 'id-wastehubnewapp@wastehubnewapp.iam.gserviceaccount.com',
    'private_key':
        '''-----BEGIN PRIVATE KEY-----\n
        MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBK2M+lCio5cco\n
        vdo/6OoFlrJIYbNQny9BbepifJySbwkt8gGzSv/a96u7fLYtKA2ppQCBZXNU1KN2\n
        UcU9sZLf9U/cktzT3YwP1/rUzbGdtkM75G3Y/OFjCFEjgSCzkkJbSTCkafDsRatR\n
        Ld8eQ0NUjwDPcHZaWkNBN87/o0DIX1tBIvdp1/T7jRImgWrufRrh6OKnAMy/hjZ7\n
        wGP7HAqY0V+6m2d3bY2rJWyzp3n85haZ7PBqrYAo+JKxYOl/JGWyrKNogEreja1e\n
        GFyoikEE5iSVsHP9EecOcxkY54j/3MNzvzrt9JLaPuRRtoRLpCwwJ807OBUUPc6k\n
        OseszrpVAgMBAAECggEALdQ54QRsmxmcxRU53PTI5NeKZ7LKRKPnpbnKpGAVE4bF\n
        YkGq1ptCFXSyKTKe1BrPFwL/GjP0B1nFiFJBHfBtvLWqI1Yyjw9eZfnjWC6O57Bw\n
        xhpdV2Azpve3rFk75W6bUKYOJMu/rYaf7QwZhcgGht7AnfZ8FdaZYzU25p6YRZE0\n
        gDEjtLAo16QeqXtC872yP5g0BtIXvRT5ItqcdfxaQ6h4VbbeXG6GETlYQyX5YA7Z\n
        9LECiuItshvjT3TpraIZv7vZ7BVy/ANk6QOupVSji2/j0+G2BZNSO7l2uB7u1yft\n
        RO2Is/fWPwrsHOm4La6nbijhNk208+Rko7mJmj5kRwKBgQDiLRjsNSiu96p5jtZa\n
        +koYqGigOsdhve+g0Mifq2opZf4wKzvdQOnYR3Y93UiUjiQAE1L+eRiMEX2Kwqm5\n
        slyPqUda4A8nG5kaTB4KjVJEbJyxif72j8aeoMfkLMtFIZfNn/TQnh3bAs/iPDqa\n
        eUsK7eURZ6pRaMoYgtgdo4o3mwKBgQDapBouRzv4qNQHMzXtCmhWdgR5/YwV+Mrp\n
        78LaRgRH68ryAyYknPWNmTylqZ/MoNCosI3B5tXF+lQgXleKpIUhs9ojaiH6CnR2\n
        8SM7js3GilFZGejtibkKBtouYmwvWhQvYbojSq9GDGGLtt1bj5IJucnkz+ARE5Ok\n
        36GNupmMzwKBgQDhW7X9hWooDDYcMKp8s+6oawT0whxv02S0g9Oi5JU+8pU3QZzA\n
        dDGMgofaVGZBPu+384k6bUZ8KeFBJX0fvgxkSHMEpUPz35fJkBZOxUk3TFFExQ76\n
        dX+eBu2k+M0A8Nvk0oCIbUOqOT8RWJm72SdgmHEpynT18MeNbLIRtiW+CQKBgBXm\n
        AclI0TTik/n0ox4OwMyIHYKqZnF87bXokbeS87LQZw8+SX+5SM7Z3j0pdBvmr391\n
        z3zwRdECdZKYYGQ+ficWAG8znhuRGIEhPcolT27nQ6aM9ct009exQAENUpCbkRH9\n
        08rdHBkD/HEl653UD2hx90q3l1WehFcrHt83JVH5AoGADkO4wUaxP0mTcqsWzUlG\n
        knvmBA6btnIwMvhgb7XH8ZezRkxIVZlYXhQycgY494W7uP2oKyx6OQpIPZz8ZJau\n
        xH21Zy3gTJKo1aMCBmVP5ffJzaELIMf3Ka4wLGF3MTJuF2ceIxWY3/d24vjD91sS\n
        NMqdGLZL5TQ4CJNEZ799U/w=\n-----END PRIVATE KEY-----''',
    'client_id': '108196520267237787336',
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
        '$sheetName!A3:F', // Append to any column in the sheet
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
