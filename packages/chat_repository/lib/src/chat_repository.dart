import 'package:chat_repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatRepository {
  ChatRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  final FirebaseFirestore _firestore;
  var uuid = const Uuid();
  // get  menu per merchant
  Future<void> addMessageUser(
    String idMerchant,
    String message,
    String source,
  ) async {
    final id = uuid.v4();
    final data = PushMessage(
        source: source, dest: idMerchant, message: message, messageId: id);
    // final data = {
    //   'dest': idMerchant,
    //   'message': message,
    //   'messageId': id,
    //   'source': source
    // };

    // add to firestore
    await _firestore.collection('push-message').doc(id).set(data.toJson());
  }

  Future<List<ChatRoom>> getChatRoomsUserDetail(
      String iduser, String idMerchant) async {
    try {
      final snapshot = _firestore.collection('chat-rooms').doc(iduser);
      final data = await snapshot.collection(idMerchant).get();
      final documents = data.docs;
      return documents.toListChat();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<ChatRoom>> getStreamChatRoomsUserDetail(
      String iduser, String idMerchant) async* {
    yield* _firestore
        .collection('chat-rooms')
        .doc(iduser)
        .collection(idMerchant)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ChatRoom.fromJson(e.data())).toList());
    // try {
    //   final snapshot = _firestore.collection('chat-rooms').doc(iduser);
    //   final data = await snapshot.collection(idMerchant).get();
    //   final documents = data.docs;
    //   yield documents.toListChat();
    // } catch (e) {
    //   throw Exception('Failed to get kawasan');
    // }
  }
}

extension on List<QueryDocumentSnapshot> {
  List<ChatRoom> toListChat() {
    final leaderboardEntries = <ChatRoom>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(ChatRoom.fromJson(data));
        } catch (error) {
          print(error.toString());
          throw Exception();
        }
      }
    }

    return leaderboardEntries;
  }
}
