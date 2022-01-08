import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/btn.dart';
import 'package:bank_ui_moh_dev/widgets/my_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _email = '';
  late String _password = '';
  final _auth = FirebaseAuth.instance;
  final TextEditingController _msgController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  bool _isShowLoading = false;
  bool _isLogin = false;
  var _color = Colors.orange;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _header(),
          const SizedBox(height: 20.0),
          TextField(
            textAlign: TextAlign.center,
            // controller: _emailController,
            onChanged: (value) {
              _email = value;
              // print('_email = $_email');
            },
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          DelayAnimation(
            duration: const Duration(milliseconds: 400),
            child: TextField(
              textAlign: TextAlign.center,
              // controller: _passwordController,
              onChanged: (value) {
                _password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          _isShowLoading == false
              ? MyButton(
                  color: Colors.blue[800]!,
                  title: 'register',
                  onPressed: () async {
                    _isShowLoading = false;
                    setState(() {
                      _isShowLoading = true;
                    });
                    try {
                      await _auth.createUserWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      setState(() {
                        _isShowLoading = false;
                      });
                      // Push.toPage(context, const ChatScreen());
                    } catch (e) {
                      setState(() {
                        _isShowLoading = false;
                      });
                      print('ex $e');
                    }
                    // print('_email = $_email and password = $_password');
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          _isShowLoading == false
              ? MyButton(
                  color: Colors.blue[800]!,
                  title: 'login',
                  onPressed: () async {
                    setState(() {
                      _isShowLoading = true;
                      _isLogin = true;
                    });
                    _getColor();
                    try {
                      final _user = await _auth.signInWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      // if (_user != null) {
                      //   setState(() {
                      //     _isShowLoading = false;
                      //   });
                      //   Push.toPage(context, const ChatScreen());
                      // } else {
                      //   setState(() {
                      //     _isShowLoading = false;
                      //   });
                      //   print('check info login');
                      // }
                    } catch (e) {
                      setState(() {
                        _isShowLoading = false;
                      });
                      print('ex $e');
                    }
                    // print('_email = $_email and password = $_password');
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          InkWell(
            onTap: () {
              Push.toPage(context, LoginWithTouchIDView());
            },
            child: Text(
              'Login with touch id',
              style: TxtStyle.style(fontSize: 20.0),
            ),
          )
        ]
            .map(
              (e) => Padding(
                padding: EdgeInsets.all(_padding(e)),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }

  void _getColor() {
    if (_isLogin) {
      _color = Colors.red;
    } else {
      _color = Colors.red;
    }
    setState(() {});
  }

  AnimatedContainer _header() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: 200.0,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(70.0),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10.0,
            child: Text(
              _isLogin ? 'Login' : 'Sign Up',
            ),
          ),
        ],
      ),
    );
  }

  double _padding(Widget e) {
    if (e is Container) {
      return 0.0;
    }
    return 10.0;
  }
}

class LoginWithTouchIDView extends StatelessWidget {
  const LoginWithTouchIDView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            DelayAnimation(
              duration: const Duration(milliseconds: 500),
              child: Icon(
                Icons.fingerprint,
                size: 70.0,
              ),
            ),
            const SizedBox(height: 50.0),
            Text(
              'login with touch id',
              style: TxtStyle.style(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'use login with touch id with easy access',
              style: TxtStyle.style(
                fontSize: 13.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30.0),
            DelayAnimation(
              duration: const Duration(milliseconds: 800),
              child: MyBtn(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(20.0),
                color: Colors.black.withOpacity(.6),
                radius: 20.0,
                child: Text(
                  'use login with touch id with easy access',
                  style: TxtStyle.style(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            MyBtn(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              padding: const EdgeInsets.all(20.0),
              color: Colors.black.withOpacity(.04),
              radius: 20.0,
              elevation: 0.0,
              child: Text(
                'login with email',
                style: TxtStyle.style(
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

//////

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();

    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     setState(() {
    //       _keyboardVisible = visible;
    //       print("Keyboard State Changed : $visible");
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = Color(0xFFBD34C59);
        _headingColor = Colors.white;

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 40 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Color(0xFFBD34C59);
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginYOffset = _keyboardVisible ? 30 : 240;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;

        _loginXOffset = 20;
        _registerYOffset = _keyboardVisible ? 55 : 270;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        break;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              color: _backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 0;
                      });
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 1000),
                            margin: EdgeInsets.only(
                              top: _headingTop,
                            ),
                            child: Text(
                              "Learn Free",
                              style:
                                  TextStyle(color: _headingColor, fontSize: 28),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              "We make learning easy. Join Tvac Studio to learn flutter for free on YouTube.",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: _headingColor, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Center(
                      child: Image.asset("assets/images/splash_bg.png"),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_pageState != 0) {
                            _pageState = 0;
                          } else {
                            _pageState = 1;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(32),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFB40284A),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          AnimatedContainer(
            padding: EdgeInsets.all(32),
            width: _loginWidth,
            height: _loginHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform:
                Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(_loginOpacity),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Login To Continue",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    InputWithIcon(
                      icon: Icons.email,
                      hint: "Enter Email...",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputWithIcon(
                      icon: Icons.vpn_key,
                      hint: "Enter Password...",
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    PrimaryButton(
                      btnText: "Login",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 2;
                        });
                      },
                      child: OutlineBtn(
                        btnText: "Create New Account",
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          AnimatedContainer(
            height: _registerHeight,
            padding: EdgeInsets.all(32),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Create a New Account",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                InputWithIcon(
                  icon: Icons.email,
                  hint: "Enter Email...",
                ),
                SizedBox(
                  height: 20,
                ),
                InputWithIcon(
                  icon: Icons.vpn_key,
                  hint: "Enter Password...",
                ),
                Column(
                  children: <Widget>[
                    PrimaryButton(
                      btnText: "Create Account",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 1;
                        });
                      },
                      child: OutlineBtn(
                        btnText: "Back To Login",
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({required this.icon, required this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60,
            child: Icon(
              widget.icon,
              size: 20,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: widget.hint,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;

  const PrimaryButton({Key? key, required this.btnText}) : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFB40284A), borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({required this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFB40284A), width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 16),
        ),
      ),
    );
  }
}
