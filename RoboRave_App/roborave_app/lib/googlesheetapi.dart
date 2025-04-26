import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApi {
  static Future<SheetsApi> _getSheetsApi() async {
    final credentials = ServiceAccountCredentials.fromJson({
      'type': 'service_account',
      'client_email': 'approborave@approborave.iam.gserviceaccount.com',
      'private_key':
          '-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQClX2BBclOS/fJH\nwVuINcqFDFp26v2TakkAy0S10ZVLfIbS6boCy6xw3sB4nvCgoBCdRdwrhxnajb+t\nc1jITDzWKYVcJQxbm9iLJoKNaf8RtuZJHssFr5wyfwdJWrsXzx+9MPESCJ483OXI\nrFqHrJ6DOGy91NOURuj13G1bfAyEN+KnRDnw0EKgmiLc3xoWD4UMshuosWau1TS/\nYPecGA4GL5kUm9rdWOuvcZQteUbS2h6mQfiaEgLuAMJo0d08bhNr0mb/TB5SEx4i\nyOLKPs4gZoM9hHuJKxlcfgCHullip4KvYt9aMbtzXCgSYsiXubvahywHbeB+w8cu\nFMmT/v8NAgMBAAECggEAJW3FympG0iEZ4fW4csbB9IUMQJgFFoVayow3G/O4l6Iy\nna/6wsE4YT95TpOioKg5um7iWxOz3Uxx0p8lvAfNSSeSoH1eI6nNRAlOSRVxfp/n\n1SrcBohtkNxBWO/pIoVliJt4JH3A2sOgWl/wCX8fTVHLAtgVnxzBg0wFkEwuRQpH\nrY3glbgmmRPI+0ewCydD3H8fo6xTwcA6H1pRHiKMrl12zTo0/rZkV+dESvMbVHtl\nlL92Hmr9nTN+Ik3wpVdPEdGy9Gq0Q2L9rsq6U/R/fQlVLVZCccFEf9yDih3lNtJ9\nDFAim4hw3MwxRUyj1+rhi/1lDlhS6YQ/zY0NpJuyYQKBgQDcYajEhmcqtPgviJGU\nrOPluDAz4n9QCCq31DF7w8TkzOwZ/+VFDjbZeErFS+Mn3Bg67G8ZMzCvPFioqjoQ\nn0fottrN8Vtag8HMBr3OTNArqGZCWyxwVQE3ajO/7Sp0sa/qm9ie92ZNj1fiUnBT\ne6HIY73aMoymVN/UqzD+wihceQKBgQDAGbVhBdA+cCx3/ydN9gOmlTpvLFEPhZTC\n5KdxEVYh+fkbqIAT+PHMGuNtJAsP1cNj1ecwR10bSfJTL3JzueLDmbycc9M9lSKD\nfaKBvmW4sFqmxMWkGW9GodRIDHZ3Ix9BzY1pRxxU7in265ifdAgvi07ihEZKVoBt\nbpiOyDgqNQKBgEx0VOhY+FGIltFmv5qkoCuByrc1TJWnP6qmosQdFqGJth8O96sN\nU1n+sXHg8d1SLdXDUIedirZAaUGaTKqXl4rUZPQtV1P/gawWaqK3Y0DCGzfKCZCu\n7M0cuvdKgAAb5LuvdWcwzPz7TbHmh7FuoqGyeJrKDqFlsIFHIqg/E2GBAoGBAJQJ\nO8Vw/XGgcCRo9JkXpOiSx101AaK8hk9Kdd6kRYQZZubxiwHZLjzj268Xv46MZO5i\nwK5r0ExfR+bjAYg9D4s8xiSq/XbPnrFF+B2T5D/XZ4RszwIOt7nuq/B56jEVV9kV\n1ovyyNqKTryCAjOe70/0Qu48kQ5oar/qIpalpOKhAoGBAIK0HietugUIem4V9Mfx\nN3my0tKLicZfCPbERCdKR3+dryCJXMB5+aiD0mcyU+5obtr5QoUNCDZRnGGHYklb\nzbXXxgS7+XV/LtZjr4BOAQcQj1hdZYBR+WN+1eM7XMRkd9nhky+FrcCK0LHk5ioD\nSPMbkgDjtwmN7eZ6QcJZDvui\n-----END PRIVATE KEY-----',
      'client_id': '102762478996673482910',
    });

    final client = await clientViaServiceAccount(
      credentials,
      [SheetsApi.spreadsheetsReadonlyScope],
    );
    return SheetsApi(client);
  }

  static Future<List<List<String>>> getSheetData(
      String spreadsheetId, String range) async {
    try {
      final sheets = await _getSheetsApi();
      final response =
          await sheets.spreadsheets.values.get(spreadsheetId, range);
      return response.values
              ?.map((row) => row.map((cell) => cell.toString()).toList())
              .toList() ??
          [];
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
