import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/view/widget/one_answer_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String textFormFieldText = '';

  void _join() async {
    if (_formKey.currentState?.validate() ?? false) {
      QuerySnapshot nicknameQuery = await FirebaseFirestore.instance
          .collection('user')
          .where('nickname', isEqualTo: controller.text)
          .get();
      if (nicknameQuery.docs.isNotEmpty) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return OneAnswerDialog(
                    onTap: () {
                      context.pop();
                    },
                    title: '이미 존재하는 닉네임 입니다.',
                    firstButton: '닫기');
              });
          return;
        }
      }
      UserCredential user = await FirebaseAuth.instance.signInAnonymously();
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.user!.uid)
          .set({'nickname': controller.text});
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        context.push('/Menu');
        return;
      }
      context.go('/');
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue[400] as Color,
            Colors.blue[600] as Color,
            Colors.blue[800] as Color
          ])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Tic-Tac-Toe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    controller: controller,
                    onChanged: (text) {
                      setState(() {
                        textFormFieldText = text;
                      });
                    },
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    maxLength: 10, // 글자수 제한
                    validator: (value) {
                      // 유효성 검사
                      if (value == null || value.isEmpty) {
                        return '닉네임을 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        // 기본디자인
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        // 눌렀을때 디자인
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.amber,
                          ),
                        ),
                        suffixIcon: textFormFieldText.isEmpty
                            ? null
                            : GestureDetector(
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  setState(() {
                                    controller.clear();
                                    textFormFieldText = '';
                                  });
                                },
                              ),
                        hintText: '닉네임 설정(최대 10글자)',
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _join,
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 52)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white70)),
                  child: const Text(
                    'Join',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
