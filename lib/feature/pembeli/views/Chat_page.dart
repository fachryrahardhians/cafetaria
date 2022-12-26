import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/pembeli/views/widget/chat_message.dart';
import 'package:cafetaria/feature/pembeli/views/widget/message_widget.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String idMerchant;
  final String iduser;
  final String title;
  const ChatPage(
      {Key? key,
      required this.idMerchant,
      required this.title,
      this.iduser = ""})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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

  final _controller = TextEditingController();
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: const Color(0xffFCFBFC),
          elevation: 0),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: StreamBuilder<List<ChatRoom>>(
                  stream: context
                      .read<ChatRepository>()
                      .getStreamChatRoomsUserDetail(
                          widget.iduser, widget.idMerchant),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Ada masalah ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final messages = snapshot.data;
                      messages!.sort(
                        (a, b) => b.createdAt.compareTo(a.createdAt),
                      );
                      return messages.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                return SizedBox(
                                  child: MessageWidget(
                                      message: message,
                                      isMe: message.source == widget.iduser),
                                );
                              },
                            )
                          : buildText(
                              "Lakukan Percakapan pertama kali dengan ${widget.title}");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
          ChatMessage(idMerchant: widget.idMerchant)
        ],
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
