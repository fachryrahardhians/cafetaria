import 'package:cafetaria/feature/penjual/bloc/user_bloc/user_bloc.dart';
import 'package:cafetaria/feature/penjual/views/Chat_page_merchant.dart';
import 'package:cafetaria/feature/penjual/views/widgets/user_Widget.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListMerchantWidget extends StatelessWidget {
  final String id;
  const ChatListMerchantWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(chatRepository: context.read<ChatRepository>())
            ..add(const GetListUser()),
      child: ChatListMerchant(
        id: id,
      ),
    );
  }
}

class ChatListMerchant extends StatefulWidget {
  final String id;
  const ChatListMerchant({Key? key, required this.id}) : super(key: key);

  @override
  State<ChatListMerchant> createState() => _ChatListMerchantState();
}

class _ChatListMerchantState extends State<ChatListMerchant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("CHATROOM"),
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: const Color(0xffFCFBFC),
          elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<UserBloc, UserState>(builder: ((context, state) {
            if (state.status == UserStatus.loading) {
              return const CircularProgressIndicator();
            } else if (state.status == UserStatus.success) {
              //inisialisasi fungsi future untuk menginput list merchant yang memiliki list menu
              List<UserModelChat> merchant = [];
              Future<List<UserModelChat>> listUser() async {
                for (var element in state.items!) {
                  final chat = await context
                      .read<ChatRepository>()
                      .getChatRoomsMerchantDetail(element.userId, widget.id);
                  if (chat.isEmpty) {
                    print("data Kosong");
                  } else {
                    try {
                      merchant.add(element);
                    } catch (e) {
                      throw Exception('Failed to get All menu');
                    }
                  }
                }
                return merchant;
              }

              return FutureBuilder<List<UserModelChat>>(
                  future: listUser(),
                  builder: (context, snapshot) {
                    // print(snapshot.data?.length);
                    return snapshot.data?.length == null
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ChatPageMerchant(
                                                        iduser: snapshot
                                                            .data![index]
                                                            .userId,
                                                        idMerchant: widget.id,
                                                        title: snapshot
                                                            .data![index]
                                                            .fullname
                                                            .toString())));
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.safeBlockVertical *
                                                      3),
                                          child: userwidget(
                                              snapshot.data![index].fullname
                                                  .toString(),
                                              snapshot.data![index].email
                                                  .toString())));
                                })),
                          ));
                  });
            } else if (state.status == UserStatus.failure) {
              return Text(state.errorMessage.toString());
            } else {
              return const SizedBox();
            }
          }))
        ],
      ),
    );
  }
}
