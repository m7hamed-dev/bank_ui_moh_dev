import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/btn.dart';
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
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  bool _isShowLoading = false;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Placeholder(
              fallbackHeight: 200.0,
            ),
            SizedBox(height: 50),
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
            SizedBox(height: 8),
            TextField(
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
            SizedBox(height: 10),
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
                        Push.toPage(context, const ChatScreen());
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
            SizedBox(height: 10),
            _isShowLoading == false
                ? MyButton(
                    color: Colors.blue[800]!,
                    title: 'login',
                    onPressed: () async {
                      setState(() {
                        _isShowLoading = true;
                      });
                      try {
                        final _user = await _auth.signInWithEmailAndPassword(
                          email: _email,
                          password: _password,
                        );
                        if (_user != null) {
                          setState(() {
                            _isShowLoading = false;
                          });
                          Push.toPage(context, const ChatScreen());
                        } else {
                          setState(() {
                            _isShowLoading = false;
                          });
                          print('check info login');
                        }
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
                  )
          ],
        ),
      ),
    );
  }
}

////////////////////////// CHAT PAGE
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late User signInUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _fireStore = FirebaseFirestore.instance;
  void _getCurrentUser() {
    try {
      final _user = _auth.currentUser;
      if (_user != null) {
        signInUser = _user;
        print('current user = ${signInUser.email}');
      }
    } catch (e) {
      print('ex $e');
    }
  }

  Future _getFutureMessages() async {
    try {
      final _messages = await _fireStore.collection('msgCollection').get();
      for (var msg in _messages.docs) {
        print('msg = ${msg.data()}');
      }
    } catch (e) {
      print('ex $e');
    }
  }

  Future _getStreamMessages() async {
    try {
      await for (var msg
          in _fireStore.collection('msgCollection').snapshots()) {
        for (var item in msg.docs) {
          print('item = ${item.data()}');
        }
      }
    } catch (e) {
      print('ex $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getStreamMessages();
  }

  String _msgTxt = '';
  List<Text> _txtsWidget = <Text>[];
  var _msgText = '';
  var _senderMsgText = '';
  Text _msgWidget = const Text('data');

  ///
  @override
  Widget build(BuildContext context) {
    _getStreamMessages();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        // title: Row(
        //   children: [
        //     Image.asset('images/logo.png', height: 25),
        //     SizedBox(width: 10),
        //     Text('MessageMe')
        //   ],
        // ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _fireStore.collection('collectionPath').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  //
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final messgaes = snapshot.data!.docs;
                  for (var message in messgaes) {
                    _msgText = message.get('msg');
                    _senderMsgText = message.get('sender');
                    _msgWidget = Text(
                      '$_msgText - $_senderMsgText',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    );
                    _txtsWidget.add(_msgWidget);
                  }
                  //
                  return Column(
                    children: _txtsWidget,
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          _msgTxt = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'Write your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_msgTxt.isNotEmpty) {
                          _fireStore.collection('msgCollection').add({
                            'msg': _msgTxt,
                            'sender': signInUser.email,
                          });
                        }
                      },
                      child: Text(
                        'send',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
