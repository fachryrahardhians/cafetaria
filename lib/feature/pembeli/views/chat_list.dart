import 'package:cafetaria/feature/pembeli/bloc/list_merchant_bloc/list_merchant_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/Chat_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_repository/merchant_repository.dart';

class ChatList extends StatelessWidget {
  final String idUser;
  const ChatList({Key? key, this.idUser = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ListMerchantBloc(
                merchantRepository: context.read<MerchantRepository>())
              ..add(const GetListMerchant()),
          )
        ],
        child: ChatListWidget(
          idUser: idUser,
        ));
  }
}

class ChatListWidget extends StatefulWidget {
  final String idUser;
  const ChatListWidget({Key? key, this.idUser = ""}) : super(key: key);

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("CHATROOM"),
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: const Color(0xffFCFBFC),
          elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ListMerchantBloc, ListMerchantState>(
              builder: ((context, state) {
            if (state.status == ListMerchantStatus.loading) {
              return const CircularProgressIndicator();
            } else if (state.status == ListMerchantStatus.success) {
              //inisialisasi fungsi future untuk menginput list merchant yang memiliki list menu
              List<MerchantModel> merchant = [];
              Future<List<MerchantModel>> listmerchant() async {
                for (var element in state.items!) {
                  final chat = await context
                      .read<ChatRepository>()
                      .getChatRoomsUserDetail(
                          widget.idUser, element.merchantId.toString());
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

              return FutureBuilder<List<MerchantModel>>(
                  future: listmerchant(),
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
                                                builder: (_) => ChatPage(
                                                    iduser: widget.idUser,
                                                    idMerchant: snapshot
                                                        .data![index].merchantId
                                                        .toString(),
                                                    title: snapshot
                                                        .data![index].name
                                                        .toString())));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: SizeConfig.safeBlockVertical *
                                                3),
                                        child: outlet(
                                            Assets.images.illCafetariaBanner2
                                                .path,
                                            snapshot.data?[index].image,
                                            false,
                                            snapshot.data?[index].name ??
                                                'Shabrina’s Kitchen - Gambir',
                                            'Lantai 1',
                                            'Cafetaria',
                                            '${snapshot.data?[index].rating} • ${snapshot.data?[index].totalCountRating} rating'),
                                      ));
                                })),
                          ));
                  });
            } else if (state.status == ListMerchantStatus.failure) {
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
