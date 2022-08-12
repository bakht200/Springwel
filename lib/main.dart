import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:springwel/config.dart';
import 'package:springwel/screens/home_screen.dart';
import 'package:springwel/screens/product_detail_screen.dart';

import 'controller/login_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      }));
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        PRIMARY_COLOR,
        Color(0xFFFF658D),
        Color.fromARGB(255, 134, 97, 114)
      ])),
      child: ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80.h,
              ),
              Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.r),
                          topRight: Radius.circular(60.r))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30.sp),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60.h,
                          ),
                          Container(
                            child: Image.asset("images/logo.png"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20.r,
                                      offset: Offset(0, 10))
                                ]),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]!))),
                                    child: TextFormField(
                                      validator: (val) => val!.isEmpty
                                          ? "Enter a username"
                                          : null,
                                      controller: userName,
                                      decoration: InputDecoration(
                                          hintText: "Enter username",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.sp),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]!))),
                                    child: TextFormField(
                                      validator: (val) => val!.isEmpty
                                          ? "Enter a password"
                                          : null,
                                      controller: password,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .login(userName.text.trim(),
                                        password.text.trim(), context);
                              }
                            },
                            child: Container(
                              height: 50.h,
                              margin: EdgeInsets.symmetric(horizontal: 50.sp),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: PRIMARY_COLOR),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    ));
  }
}
