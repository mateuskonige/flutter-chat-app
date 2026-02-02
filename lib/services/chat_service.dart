import 'package:chat_app/models/message.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // instance os firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

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
  Future<void> sendMessage(receiverId, message) async {
    // get current user info
    final String currentUserId = _authService.currentUser!.uid;
    final String currentUserEmail = _authService.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room with 2 users
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort to be unique
    String chatRoomId = ids.join("_");

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
