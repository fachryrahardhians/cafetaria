import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessageMerchant extends StatefulWidget {
  final String idUser;
  const ChatMessageMerchant({Key? key, required this.idUser}) : super(key: key);

  @override
  State<ChatMessageMerchant> createState() => _ChatMessageMerchantState();
}

class _ChatMessageMerchantState extends State<ChatMessageMerchant> {
  final _controller = TextEditingController();
  String message = '';
  void sendMessage() async {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    FocusScope.of(context).unfocus();
    await auth.getCurrentUser().then((value) {
      context
          .read<ChatRepository>()
          .addMessageMerchant(widget.idUser, message, value!.uid)
          .then((data) {
        // context
        //     .read<ChatRepository>()
        //     .getChatRoomsUserDetail(value.uid, widget.idMerchant);
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e),
          ),
        );
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
