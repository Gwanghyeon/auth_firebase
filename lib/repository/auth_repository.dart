import 'package:authentification_firebase/const/db_constants.dart';
import 'package:authentification_firebase/models/custom_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  AuthRepository({required this.firebaseFirestore, required this.firebaseAuth});

  // FirebaseAuth : 유저의 상태를 스트림으로 알려주는 함수를 사용할 수 있도록 선언
  // 가입, 로그인, 로그아웃의 상태 변화를 listen 할 수 있도록 listener 로 설정
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  // 가입 함수
  Future<void> signup(
      {required String name,
      required String email,
      required String password}) async {
    // name for accessing User collection
    try {
      // 로그인 성공시 UserCredential 획득
      final fbAuth.UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // UserCredential의 user 정보를 저장
      final signedUser = userCredential.user!;
      // 해당 User 정보를 바탕으로 Collection 에 새로운 document 생성
      // usersRef : instance of user collection defined in const.dart
      await usersRef.doc(signedUser.uid).set(
        {
          'name': name,
          'email': email,
          'profileImage': 'http://picsum.photos/300',
          'point': 0,
          'rank': 'bronze',
        },
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: '가입을 위한 서버와의 통신에 실패하였습니다. 인터넷 연결을 확인하여 주세요.');
    }
  }

  // 로그인 함수
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // 로그인에 성공하면 User 의 정보가 변화 -> user getter 의 값 변화 <Stream>
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: '로그인에 실패하였습니다. 인터넷 연결을 확인하여 주세요.');
    }
  }

  // 로그아웃 함수
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
