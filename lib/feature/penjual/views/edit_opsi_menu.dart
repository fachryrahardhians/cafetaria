import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/list_opsi_menu_bloc/list_opsi_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_opsi_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:cafetaria/feature/penjual/views/penjual_dashboard_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditOpsiMenu extends StatelessWidget {
  final String? id;
  final String? title;
  const EditOpsiMenu({Key? key, this.id, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ListOpsiMenuBloc(
                optionMenuRepository: context.read<OptionMenuRepository>())
              ..add(GetListOpsiMenu(id.toString())),
          )
        ],
        child: EditPage(
          title: title,
        ));
  }
}

class EditPage extends StatefulWidget {
  final String? title;
  const EditPage({Key? key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final oCcy = NumberFormat("#,##0.00", "IDR");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu ${widget.title}'),
        iconTheme: const IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocBuilder<ListOpsiMenuBloc, ListOpsiMenuState>(
          builder: (context, state) {
            final status = state.status;
            if (status == ListOpsiMenuStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (status == ListOpsiMenuStatus.failure) {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            } else if (status == ListOpsiMenuStatus.success) {
              final items = state.items!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: 5,
                    //   itemBuilder: (context, index) {
                    Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(4.0),
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.04),
                              offset: Offset(0, 4),
                              blurRadius: 12,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.04),
                                    offset: Offset(0, 4),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index].title.toString(),
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                        // ListView.builder
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: SizedBox(
                                            height: 16,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.7,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  items[index].option.length,
                                              itemBuilder: (context, length) {
                                                return Text(
                                                  " ${items[index].option[length].name.toString()}, ",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return dialogWarnCart(
                                                  items[index].optionmenuId);
                                            },
                                          );
                                        },
                                        child: const Text(
                                          'Hapus',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddOpsiMenuPage(
                                                        menuId: items[index]
                                                            .menuId!,
                                                        optionMenuModel:
                                                            items[index],
                                                      )));
                                        },
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        //   );
                        // },
                        ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Dialog dialogWarnCart(String optionMenuId) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icGrfxWarning.image(),
          const Text(
            "Apa anda yakin ingin menghapus opsi menu ?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff222222),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Text(
              "Data opsi menu akan kehapus dan tidak bisa kembali lagi",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff808285),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 44,
                      margin: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              side: const BorderSide(
                                color: MyColors.red1,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide.none)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "TIDAK",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(1)),
                          )))),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 44,
                      margin: const EdgeInsets.only(left: 8),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffee3124)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide.none))),
                          onPressed: () async {
                            // addMenuToCartBloc.add(RemoveAllMenuInCart());
                            SharedPreferences idmercahnt =
                                await SharedPreferences.getInstance();
                            String id =
                                idmercahnt.getString("merchantId").toString();
                            await context
                                .read<OptionMenuRepository>()
                                .deleteOptionMenu(optionMenuId)
                                .then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "YA HAPUS",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(1)),
                          ))))
            ],
          )
        ],
      ),
    ));
  }
}
