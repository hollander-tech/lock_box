import 'package:cloud_firestore/cloud_firestore.dart';

class Password {
  final String docId;
  final String title;
  final String username;
  final String password;
  final String url;
  final String notes;
  final DateTime lastUpdated;

  Password(
      {required this.docId,
      required this.title,
      required this.username,
      required this.password,
      required this.url,
      required this.notes,
      required this.lastUpdated});

  Password.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : docId = snapshot.id,
        title = (snapshot.data() as Map<String, dynamic>?)?['title'] ?? '',
        username =
            (snapshot.data() as Map<String, dynamic>?)?['username'] ?? '',
        password =
            (snapshot.data() as Map<String, dynamic>?)?['password'] ?? '',
        url = (snapshot.data() as Map<String, dynamic>?)?['url'] ?? '',
        notes = (snapshot.data() as Map<String, dynamic>?)?['notes'] ?? '',
        lastUpdated = (snapshot.data() as Map<String, dynamic>?)?['lastUpdated']
                ?.toDate() ??
            DateTime.now();
  Map<String, dynamic> toMap() => {
        'title': title,
        'username': username,
        'password': password,
        'url': url,
        'notes': notes,
        'lastUpdated': Timestamp.fromDate(lastUpdated),
      };
}
