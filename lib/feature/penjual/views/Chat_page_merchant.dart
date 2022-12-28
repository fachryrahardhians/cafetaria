import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/pembeli/views/widget/chat_message.dart';
import 'package:cafetaria/feature/pembeli/views/widget/message_widget.dart';
import 'package:cafetaria/feature/penjual/views/widgets/chat_message_merchant.dart';
import 'package:cafetaria/feature/penjual/views/widgets/message_widget_merchant.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPageMerchant extends StatefulWidget {
  final String idMerchant;
  final String iduser;
  final String title;
  const ChatPageMerchant(
      {Key? key,
      required this.idMerchant,
      required this.title,
      this.iduser = ""})
      : super(key: key);

  @override
  State<ChatPageMerchant> createState() => _ChatPageMerchantState();
}

class _ChatPageMerchantState extends State<ChatPageMerchant> {
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
                      .getStreamChatRoomsMerchantDetail(
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
                                  child: MessageWidgetMerchant(
                                      message: message,
                                      isMe: message.source == widget.idMerchant),
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
          ChatMessageMerchant(idUser: widget.iduser)
        ],
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      );
}
