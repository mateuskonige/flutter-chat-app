import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // instance os firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((event) {
      return event.docs.map((e) {
        final user = e.data();
        return user;
      }).toList();
    });
  }
  // send message

  // get message
}
