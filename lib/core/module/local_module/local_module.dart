// import 'dart:async';

// import 'package:axilo/core/data/data_source/datasource.dart';
// import 'package:axilo/utils/constants/text_string.dart';
// import 'package:axilo/utils/encryption/encryption.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast_io.dart';

// class LocalModule {
//   static LocalModule? _instance;
//   factory LocalModule() => _instance ??= LocalModule._();
//   LocalModule._();

//   Future<Database> provideDatabase() async {
//     // Key for encryption
//     var encryptionKey = "";

//     // Get a platform-specific directory where persistent app data can be stored
//     final appDocumentDir = await getApplicationDocumentsDirectory();

//     // Path with the form: /platform-specific-directory/demo.db
//     final dbPath = join(
//       appDocumentDir.path,
//       // "flog.db",
//       WStrings.DB_NAME,
//     );
//     // this was written as per constant name
//     // db name can be changed later as per our own accord

//     // Check to see if encryption is set, then provide codec
//     // else init normal db with path
//     Database database;
//     if (encryptionKey.isNotEmpty) {
//       // Initialize the encryption codec with a user password
//       var codec = getXXTeaCodec(password: encryptionKey);
//       database = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
//     } else {
//       database = await databaseFactoryIo.openDatabase(dbPath);
//     }

//     // Return database instance
//     return database;
//   }

//   // DataSources:---------------------------------------------------------------
//   // Define all your data sources here
//   DataSource provideLocalModule() => DataSource(provideDatabase());
//   // DataSources End:-----------------------------------------------------------
// }
