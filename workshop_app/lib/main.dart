import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';

import 'api/api.dart';
import 'view/show_list.dart';

/* TODO
- GridView
- Logout
*/

void main() {
  runApp(const WorkshopApp());
}

class WorkshopApp extends StatelessWidget {
  const WorkshopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginWidget(),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  //region Login
  Future<String?> _validateUser(LoginData data) async {
    var result = await Api().validateUser(data);
    if (result == true) {
      return null;
    } else {
      return "Error";
    }
  }

  String? _userValidator(username) {
    return null;
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FlutterLogin(
      title: 'Login',
      onLogin: _validateUser,
      messages: LoginMessages(
        userHint: 'Username',
        passwordHint: 'Password',
      ),
      userValidator: _userValidator,
      userType: LoginUserType.name,
      hideForgotPasswordButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ShowList(
            title: "App zum Workshop",
          ),
        ));
      },
      onRecoverPassword: (String) {},
    )));
  }
}
