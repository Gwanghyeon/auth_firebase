import 'package:authentification_firebase/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/custom_error.dart';
import '../providers/signin/signin_provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  static const String routeName = '/signin';

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  // Disable validation before submitted
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    // returning when there occurs an error
    if (form == null || !form.validate()) return;
    form.save();

    try {
      context
          .read<SigninProvider>()
          .signIn(email: _email!, password: _password!);
    } on CustomError catch (e) {
      showErrorDialog(context, e);
    }
    // * 로그인 성공 시 HomePage로 이동하는 로직이 없음
    // * Since it watches the change the value of User
  }

  @override
  Widget build(BuildContext context) {
    // Watching sighin state
    final state = context.read<SigninProvider>().state;
    // Check it is not loading the state
    final isSubmitting = state.signinStatus == SigninStatus.submitting;

    // for unfocusing textFormField
    return WillPopScope(
      // 이전 화면(Splash Page)으로 이동 불가
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                // 키보드가 올라왔을 때의 overflow를 방지하기 위한 ListView
                child: ListView(
                  // 화면 중앙에 배치: Center 위젯안에 ListView를 사용시 shrinkWrap: true 필요
                  shrinkWrap: true,
                  children: [
                    Image.asset(
                      'assets/images/flutter_logo.png',
                      width: 240,
                      height: 240,
                    ),
                    SizedBox(height: 21),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: _autovalidateMode,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email required';
                        }
                        // validator의 함수 -> email 형식의 확인기능
                        if (!isEmail(value.trim())) {
                          return 'Enter a valid email';
                        }
                        // 모든 검증을 통과하였을 때
                        return null;
                      },
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 21),
                    TextFormField(
                      autovalidateMode: _autovalidateMode,
                      // 비밀번호 형식
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '비밀번호를 입력해주세요.';
                        }
                        if (value.trim().length < 6) {
                          return '비밀번호는 6글자 이상이어야 합니다.';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(height: 21),
                    ElevatedButton(
                      child: Text(isSubmitting ? 'Loading...' : 'Sign In'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(9),
                      ),
                      onPressed: isSubmitting
                          // 로그인 중이면 버튼 비활성화
                          ? null
                          : _submit,
                    ),
                    SizedBox(height: 21),
                    // 회원가입 페이지
                    TextButton(
                      child: Text('회원가입'),
                      style: TextButton.styleFrom(
                        textStyle:
                            TextStyle(decoration: TextDecoration.underline),
                      ),
                      onPressed: isSubmitting
                          ? null
                          : () {
                              Navigator.pushNamed(
                                  context, SigninPage.routeName);
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
