import 'package:cloud_firestore/cloud_firestore.dart';

class BuzzUser {
  final String userId;

  BuzzUser({
    required this.userId,
  });
}

class UserInfo {
  final String name;
  final String college;

  UserInfo({
    required this.name,
    required this.college,
  });

  factory UserInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserInfo(
      name: data?['name'] as String,
      college: data?['college'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (college != null) "college": college,
    };
  }
}
