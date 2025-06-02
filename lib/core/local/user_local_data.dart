import 'package:axilo/features/auth/model/user_model.dart';

mixin UserLocalData {
  String userType = '';
  String? accessToken;
  String? refreshToken;
  String userName = 'user';
  String userId = '';
  String email = '';

  UserModel localUserData = UserModel();

  userCleanUp() {
    userType = '';
    accessToken = null;
    refreshToken = null;
    userId = '';
    userName = '';
    email = '';
    localUserData = UserModel();
  }
}
