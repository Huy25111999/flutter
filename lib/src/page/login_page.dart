import "package:flutter/material.dart";
//import "package:mobile/src/blocs/login_bloc.dart";
import "package:mobile/src/page/home_page.dart";

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //LoginBloc bloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  var _userNameErr = "Tài khoản không hợp lệ";
  var _passErr = "Mật khẩu phải trên 6 ký tự";
  var _userInvalid = false;
  var _passInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 64),
              child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                  child: FlutterLogo()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Text('Vui lòng nhập nội dung bên dưới để đăng nhập:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30)),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                  controller: _userController,
                  decoration: InputDecoration(
                      labelText: "Username",
                      errorText: _userNameErr,
                      labelStyle:
                          TextStyle(color: Color(0xffd8d8d8), fontSize: 16)),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child:
                    Stack(alignment: AlignmentDirectional.centerEnd, children: [
                  TextField(
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                    controller: _passController,
                    obscureText: !_showPass,
                    decoration: InputDecoration(
                        labelText: "Password",
                        errorText: _passErr,
                        labelStyle:
                            TextStyle(color: Color(0xffd8d8d8), fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: onToggleShowPass,
                    child: Text(_showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                            color: Color(0xFF3306E9),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  )
                ])),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _incrementLogin,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "NEW USER ? SIGN UP",
                      style: TextStyle(fontSize: 16, color: Color(0xffd8d8d8)),
                    ),
                    Text(
                      "FORGOT PASSWORD",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    )
                  ]),
            ),
          ],
        ),
      ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
    );
  }

  void _incrementLogin() {
    setState(() {
      if (_userController.text.length < 6 ||
          !_userController.text.contains("@")) {
        _userInvalid = true;
      } else {
        _userInvalid = false;
      }

      if (_passController.text.length < 6) {
        _passInvalid = true;
      } else {
        _passInvalid = false;
      }

      // if (bloc.isValidInfo(_userController.text, _passController.text)) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => HomePage()));
      // }

      if (!_userInvalid && !_passInvalid) {
        // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  Widget gotoHome(BuildContext context) {
    return HomePage();
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
