import 'package:cloud_firestore/cloud_firestore.dart';

class LoginServices {
  getUserInformation(userName, userPassword) async {
    try {
      print(userName);
      print(userPassword);

      var response = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: userName)
          .where('password', isEqualTo: userPassword)
          .get()
          .then((value) => print(value.docs.first.data()));

      return true;
    } catch (e) {
      return null;
    }
  }
}
