import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApi {
  static const _credentials = {
    'type': 'service_account',
    'client_email': 'id-wastehubdb@wastehubdb.iam.gserviceaccount.com',
    'private_key': '''-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDAQ5frSUDrrJj5
4HYbeNwa5OMpL+Ha0VyreL2H5GgUi6KgWgwGRreQYSWQ0tx4uDp3dnvPmekDWbt5
d9ahj2Q1UrjIvf/WJuTPrgXnHDb+QYQBTVu9HVVdsRastelVM105LKjOPTPgCP6h
pmobH9pl8CArXxmy11yTeeWfj8UoRrTWNy+bgDS0maya8zFnpcM/r4FZb++ZjK7q
enctvVG0+EP1wTx+DC68t5JWOWyM09dMi3ozrUOBK7MZ1Z2ZPA+GivOgsM+eIwWV
mQaZtYxjP8Y9ev4An09lSogQKsGMxMVexrmrH1F6UpoTXRq+fybBONrQiRGv4xb/
AZk2gRBbAgMBAAECggEAB8hqBotQwRJxEU3BTcEO4+eXvH15/pIg8yiwP26DD2lo
v57gNWbVHDsMSPhdiA/wOC1yu0d8iROTNtifjABgsggeKgjOfyp+5JQx44gQzg30
VTB+wghTkCj7TEZm4pXjUM128zZRlxmZqvCFrg+F+s6Fdto4LdGqGTUYaFbAK+cy
zhbJwQWTTkOX3Ar2xw0i3tr+OuH+iSt5yMzsKbuENeUIXNRNl7UUvKzoPpsc8PdX
pLg7iJTY1048u+aMt5UqUYLX3AxklFFu541gKhWSkyRKMjIjp375kg8qjt5iMP4h
saMYDJNKAEOYtJCxzYNHFg988nVvyiNgk24vm6ay9QKBgQDxjrVRimDn0c1OgFgs
mP1n5cvxIC3UC8zdYDHU6QFQJho/dhB37FZ9KZRVUQ9GfHKXIlt4xfoC1FLfm0ft
tOgXfblz6R7Mgj2lh3O9azf04tsb97Yt7R8rfFyg+cke9WR0jkyE83NKD8byMvbV
jmWefe9pYyyf3jnma7c9gpVNXQKBgQDLwmW7fx+UZQe49Vkc5dM8VArnfs4kiJMr
/WD4eSQ6VVvQQ7vrtU+ZrYa5KsZGiyOW6MI83e0vUr/JbehA+lBSgR+M31yOis6N
wi0C8Pu8J6gA0hMYwHgIk5093zp//j93p7Tj2QWUxI6Cv0+S+0wxsxkIgia4ZiRs
B8pG2pTBFwKBgE1asO/iy3ORORjpetMVTxkFetDFyEc+XCWMV4jh8Py0pvUpns54
jZ3ZQdosciLVWXDSnM5JP+3GBp/6vwb9RtG2/juDLMy67Hjkroi7HBk8yIPlSJ7e
b3vigFtAgkp6tOeqZhCxUXsnIEORVIBA8IPXumJaUwEDDjGezvhQp/U1AoGBAKsq
vOdLHS49yMT5Zki+UDrnptldTrKmAGv9yE4zBdnzBtPncp/JifrhKMG4SyPLkrQd
B76195+/ddkyeN7M6FjGm8htgoVD2cyAB+vmoLIo5hr6Xox2ct9Rkc/+DFilLo/H
1E9raiLVE5qGN8STUiiV+TuKihhxxbryuFvZFwk1AoGBAK9QaBXxPZtZH7XV8Pe8
F0LBXdurt5JYcveAAvmMvYbXuwVhLi/jLZPMAK9Aa2GzB0MNZ7dEy75x2UN+fs+1
WsNKMR5oqVeURpGmsL43y9vHOPdiWvpe9hDHGn7HtQqYTi1hn5z7ta699eqw7jmr
iAE8SEw4HXXubsUJAwlI6FTi
-----END PRIVATE KEY-----''',
    'client_id': '111811041790645823596',
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
        '$sheetName!A2:D', // Append to any column in the sheet
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
