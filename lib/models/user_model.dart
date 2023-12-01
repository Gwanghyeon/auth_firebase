// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String profileImage; // url link 형식으로 저장
  final int point; // 사용자 활동 점수
  final String rank;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  // 파이어스토어에서 정보를 받아와 User object를 만드는 생성자
  factory User.fromDoc(DocumentSnapshot userDoc) {
    // DocumentSnapshot -> return nullable object
    // * Casting user Doc as Map<String, dynamic> not decoding
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'],
      email: userData['email'],
      profileImage: userData['profileImage'],
      point: userData['porint'],
      rank: userData['rank'],
    );
  }

  // User 정보를 받아오기 전이나 로그아웃과 같은 경우에 사용
  // User 에 null 값을 허용하지 않음으로서 용이한 코드 관리 가능
  factory User.initialize() =>
      // 중복되지 않을 값들로 초기화
      User(id: '', name: '', email: '', profileImage: '', point: -1, rank: '');

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, profileImage: $profileImage, point: $point, rank: $rank)';
  }
}
