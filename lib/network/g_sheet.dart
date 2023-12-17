import 'package:gsheets/gsheets.dart';

class GSheet{

 static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "qr-scanner-demo-404113",
  "private_key_id": "65afed91389069c4730e1449932643ed848bdc2c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQCg5ztvg4K84pnZ\nPn92zlUKO5nGDtJrgyl6KK/4En9cJB7QIfUSOyaBlA+az/Wa16dSlqyZzWFXtnxP\nI1y1FsYXzqpYge/seGfFy3r9jh0a1FnAIMNqp0rbCWpT1yOUXXzpL6xoVYyy4Qwv\niR8GHeGnZgilQ/DdtstuIMHGwzff3Et1kTCuZl8/fu0duS9KF1SUobRb9XNPM43r\nc60UVigLeJ6YQKTHEFD61mHOY0WpDk6NPPgFu1Fs5WfFfpEhd1Y/YgA0SoLkrEBo\npoNQ2y58+fSH5djzHN1HtJEr046u/tKYPZc+X3LJFTY717DadPGxEDfmnI1aNquL\nhaU5cD2vAgMBAAECgf9XMxHkb5f26iybD25yaEdYq/Q2gHBYEKrRas3CCu7ujL0a\nAqJ+1zo95tUgbKvYvrFKwaakFR3KfZs2I7Djfz09VGebg5LGCHrHBiQI8GNDRXyC\n5gGsY5vqqx1P/TWypgPhN1yHX1u2QEydXgHNng6/BT22a0Y8gGx18z5+pBzOd11l\nJ3sRITNtJoIFHLuykBibs3mrR1W2+RDXK1pqvg+z4ZQXjyy/2zq/aH1fNW0URfOP\nZxzYatc+c+9GY5IMna3eVulF5++p8BGBapCPyzTpsgU/mxQKZFbGl3cppytu6064\nQNbR64peI01NPQzU2FfGCEKXlTzLmHMG8EDpg1UCgYEAzBFvz8uSUYmldcFpfg42\nuclYm5Q2pX0NRxFQ/aBhubgw3mA80YqhrBcofMkJroLpsR63xCQXyIOtd6AaGYk5\n4XBwm+4C4GheiUMGw13f0PnThSBKvMJUZDxgAScgUHtH3uKoYkM8yiECQ4VvMX2p\n1hgfQXJO2aZ1f4SatHUPQX0CgYEAydm0ehdYPQLU4v2Wv7AEqMz6TUz3VtFGLpf6\nLD2FRoj8MZ3RbKctRCG5DhCrjClgtA6pvm3GYca3Uqnp3t1EU+MS7IYlEYIdnoRf\nbvoCQDkKFtnGh0sytNXyipWjNYUMFwn/owfhixXiyp/4sl86M4q3swG1CkzGedOX\nQbRVo5sCgYBezvsTn5CrMTgeLW3FkvT5/AGexo1c9WxlyDXIn+rHTjvmFPAsqivS\nuC+nSf+lhEzubUcTaXFjR0ogedGma4rookSvLTVI7TR+sRVDTync/TS4dPhEGkT7\nDNHNt0/cFGqfss5oWLS1dACJPkUayTdOsIZU8baQiDWuuPznOjuMQQKBgC/IQ3rr\nb83xj6e0VC1IY7H54/7Mi3iXzb9V5rj2T0hlQR4Vt++6m3KXcREtTQ6+9M9q8S/N\nGLsoqVj+NAi35GbfSCmJj9jXLl/KAjVpJYNCfWrvXpnEaVp5kxLPXXVb64LAsS1M\nvk2IfslsmRjQhhyRZ+8OJmcryYgpWJMLN4KlAoGAb+bzZUbGYOR6trRCH/Ed6ErL\n1xgpvSeHxA56o1VS8HLlCpCW/brXBnvcsn0L4rAhjh+/8A0Gmob1O329E2689F+m\nPYDHUsOdE0MrRsQrUD/WvS9me2KSJFnRgFSE2VPs0URi2aiGJFA8I9o824dUzjQz\n7q9u2R90OKYf//AKKBc=\n-----END PRIVATE KEY-----\n",
  "client_email": "qr-scanner-demo@qr-scanner-demo-404113.iam.gserviceaccount.com",
  "client_id": "114893034635644920752",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/qr-scanner-demo%40qr-scanner-demo-404113.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  /// Your spreadsheet id
  ///
  /// It can be found in the link to your spreadsheet -
  /// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
  /// [YOUR_SPREADSHEET_ID] in the path is the id your need
  static const _spreadsheetId = '1W0epU2XTcMgbzHbzPmUUVcy__eWEtsuUbV_FeviFf9Y';



  sheetFunc() async {
    // init GSheets
    final gsheets = GSheets(_credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetId);

    print(ss.data.namedRanges.byName.values
        .map((e) => {
      'name': e.name,
      'start':
      '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
      'end':
      '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
    })
        .join('\n'));

    // get worksheet by its title
    var sheet = ss.worksheetByTitle('Form Response');
    print(await sheet?.values.row(1));

    // List<String>? ids = await sheet?.values.columnByKey('ID Number');
    // print(await sheet?.values.columnByKey('ID Number'));
    // print(ids);

    List<String>? ids = await sheet?.values.columnByKey('ID Number');
    List<String>? cities = await sheet?.values.columnByKey('Location');
    List<UserData> unit = [];
    if (ids == null || cities == null) {
      print('Error: Either ID Number column or City column is null');
      return;
    }

    for (int i = 0; i < ids.length; i++) {
      String? id = ids[i];
      String? city = cities[i];
      if (id == null || city == null) {
        continue;
      }
      unit.add(UserData(id: id, loc: city));
    }
    return unit;

  //   // create worksheet if it does not exist yet
  //   sheet ??= await ss.addWorksheet('example');
  //
  //   // update cell at 'B2' by inserting string 'new'
  //   await sheet.values.insertValue('new', column: 2, row: 2);
  //   // prints 'new'
  //   print(await sheet.values.value(column: 2, row: 2));
  //   // get cell at 'B2' as Cell object
  //   final cell = await sheet.cells.cell(column: 2, row: 2);
  //   // prints 'new'
  //   print(cell.value);
  //   // update cell at 'B2' by inserting 'new2'
  //   await cell.post('new2');
  //   // prints 'new2'
  //   print(cell.value);
  //   // also prints 'new2'
  //   print(await sheet.values.value(column: 2, row: 2));
  //
  //   // insert list in row #1
  //   final firstRow = ['index', 'letter', 'number', 'label'];
  //   await sheet.values.insertRow(1, firstRow);
  //   // prints [index, letter, number, label]
  //   print(await sheet.values.row(1));
  //
  //   // insert list in column 'A', starting from row #2
  //   final firstColumn = ['0', '1', '2', '3', '4'];
  //   await sheet.values.insertColumn(1, firstColumn, fromRow: 2);
  //   // prints [0, 1, 2, 3, 4, 5]
  //   print(await sheet.values.column(1, fromRow: 2));
  //
  //   // insert list into column named 'letter'
  //   final secondColumn = ['a', 'b', 'c', 'd', 'e'];
  //   await sheet.values.insertColumnByKey('letter', secondColumn);
  //   // prints [a, b, c, d, e, f]
  //   print(await sheet.values.columnByKey('letter'));
  //
  //   // insert map values into column 'C' mapping their keys to column 'A'
  //   // order of map entries does not matter
  //   final thirdColumn = {
  //     '0': '1',
  //     '1': '2',
  //     '2': '3',
  //     '3': '4',
  //     '4': '5',
  //   };
  //   await sheet.values.map.insertColumn(3, thirdColumn, mapTo: 1);
  //   // prints {index: number, 0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}
  //   print(await sheet.values.map.column(3));
  //
  //   // insert map values into column named 'label' mapping their keys to column
  //   // named 'letter'
  //   // order of map entries does not matter
  //   final fourthColumn = {
  //     'a': 'a1',
  //     'b': 'b2',
  //     'c': 'c3',
  //     'd': 'd4',
  //     'e': 'e5',
  //   };
  //   await sheet.values.map.insertColumnByKey(
  //     'label',
  //     fourthColumn,
  //     mapTo: 'letter',
  //   );
  //   // prints {a: a1, b: b2, c: c3, d: d4, e: e5, f: f6}
  //   print(await sheet.values.map.columnByKey('label', mapTo: 'letter'));
  //
  //   // appends map values as new row at the end mapping their keys to row #1
  //   // order of map entries does not matter
  //   final secondRow = {
  //     'index': '5',
  //     'letter': 'f',
  //     'number': '6',
  //     'label': 'f6',
  //   };
  //   await sheet.values.map.appendRow(secondRow);
  //   // prints {index: 5, letter: f, number: 6, label: f6}
  //   print(await sheet.values.map.lastRow());
  //
  //   // get first row as List of Cell objects
  //   final cellsRow = await sheet.cells.row(1);
  //   // update each cell's value by adding char '_' at the beginning
  //   cellsRow.forEach((cell) => cell.value = '_${cell.value}');
  //   // actually updating sheets cells
  //   await sheet.cells.insert(cellsRow);
  //   // prints [_index, _letter, _number, _label]
  //   print(await sheet.values.row(1));
  }
}

class UserData{
  String? loc;
  String? id;

  UserData({this.id, this.loc});
}
