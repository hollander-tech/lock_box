import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/password.dart';

class PasswordProvider extends ChangeNotifier {
  late List<Password> passwords;
  bool isBusy = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late CollectionReference passwordsRef;

  PasswordProvider();

  Future<void> fetch() async {
    isBusy = true;
    try {
      passwords = [];
      await passwordsRef.get().then((querySnapshot) {
        for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
          passwords.add(Password.fromDocumentSnapshot(docSnapshot));
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isBusy = false;
    notifyListeners();
  }

  Future<void> addPassword(Password password) async {
    isBusy = true;
    try {
      await passwordsRef.add(password.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    isBusy = false;
    notifyListeners();
  }

  Future<void> updatePassword(Password password) async {
    isBusy = true;
    try {
      await passwordsRef
          .doc(password.docId)
          .update(password.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isBusy = false;
    notifyListeners();
  }

  Future<void> deletePassword(String docId) async {
    isBusy = true;
    try {
      await passwordsRef.doc(docId).delete();
      await fetch();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isBusy = false;
    notifyListeners();
  }
}
