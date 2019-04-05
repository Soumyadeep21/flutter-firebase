import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class UserManagement {
  void updateUserInfo(FirebaseUser user, String name, String photoURL) async {
    var info = UserUpdateInfo();
    info.displayName = name;
    info.photoUrl = photoURL;
    user.updateProfile(info).then((val) {
      print("Updated");
    }).catchError((e) {
      print("ERROR!!");
      print(e);
    });
  }
}
