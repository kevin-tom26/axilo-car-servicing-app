// import 'package:axilo/features/auth/model/user_model.dart';
// import 'package:axilo/utils/constants/text_string.dart';
// import 'package:sembast/sembast.dart';

// class DataSource {
//   // A Store with int keys and Map<String, dynamic> values.
//   // This Store acts like a persistent map, values of which are Flogs objects converted to Map
//   final _authDataStore = intMapStoreFactory.store(WStrings.AUTH_STORE_NAME);

//   // database instance
//   final Future<Database> _db;

//   // Constructor
//   DataSource(this._db);

//   // DB functions:--------------------------------------------------------------
//   // AUTH fuctions:-------------------------------------------------------------
//   Future<int> setAuthData(UserModel authData) async {
//     return await _authDataStore.add(await _db, authData.toMap());
//   }

//   Future<int> countUserdata() async {
//     return await _authDataStore.count(await _db);
//   }

//   Future<UserModel> getAuthData() async {
//     var finder = Finder(sortOrders: [SortOrder(Field.key, false)]);
//     var record = await _authDataStore.findFirst(await _db, finder: finder);
//     return UserModel.fromJson(record!.value);
//   }

//   Future<void> updateAuthTokens(String newAccessToken, String newRefreshToken) async {
//     var finder = Finder(sortOrders: [SortOrder(Field.key, false)]);

//     // Find the first existing record
//     var recordSnapshot = await _authDataStore.findFirst(await _db, finder: finder);

//     if (recordSnapshot != null) {
//       // Create updated data map
//       final updatedData = {
//         "accessToken": newAccessToken,
//         "refreshToken": newRefreshToken,
//       };

//       // Update the record in the database
//       await _authDataStore.update(await _db, updatedData, finder: finder);
//     }
//   }

//   Future deleteAuthData() async {
//     await _authDataStore.drop(
//       await _db,
//     );
//   }
// }
