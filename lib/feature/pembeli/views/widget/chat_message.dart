import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatefulWidget {
  final String idMerchant;
  const ChatMessage({Key? key, required this.idMerchant}) : super(key: key);

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  final _controller = TextEditingController();
  String message = '';
  void sendMessage() async {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    FocusScope.of(context).unfocus();
    await auth.getCurrentUser().then((value) {
      context
          .read<ChatRepository>()
          .addMessageUser(widget.idMerchant, message, value!.uid)
          .then((data) {
        context
            .read<ChatRepository>()
            .getChatRoomsUserDetail(value.uid, widget.idMerchant);
      });
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Type your message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) => setState(() {
                message = value;
              }),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: message.trim().isEmpty ? null : sendMessage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.red1,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
