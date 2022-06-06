import 'package:cloud_firestore/cloud_firestore.dart';

class BuzzUser {
  final String userId;
  final String name = 'New User';

  BuzzUser({
    required this.userId,
  });
}

class UserInfo {
  final String name;

  UserInfo({
    required this.name,
  });

  factory UserInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserInfo(
      name: data?['name'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
    };
  }
}
