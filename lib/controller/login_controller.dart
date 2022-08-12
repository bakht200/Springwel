import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:springwel/screens/home_screen.dart';
import 'package:springwel/services/login_services.dart';

import '../widgets/loader.dart';

class LoginProvider extends ChangeNotifier {
  LoginServices loginServices = LoginServices();

  Future<void> login(userName, userPassword, context) async {
    progressDialogue(context);
    final response =
        await loginServices.getUserInformation(userName, userPassword);
    Navigator.pop(context);
    if (response != null) {
      Fluttertoast.showToast(msg: "Login Successfull");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (builder) => MyHomePage()));
    } else {
      Fluttertoast.showToast(msg: "Login Failed");
    }

    notifyListeners();
  }
}
