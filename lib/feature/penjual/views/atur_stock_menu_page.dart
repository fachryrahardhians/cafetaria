import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_penjual_page.dart';
import 'package:cafetaria/feature/penjual/views/add_opsi_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/stock_menu_detail_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';

class AturStockMenuPage extends StatefulWidget {
  final String judul;
  const AturStockMenuPage({Key? key, this.judul = "Deskripsi Menu"})
      : super(key: key);

  @override
  State<AturStockMenuPage> createState() => _AturStockMenuPageState();
}

class _AturStockMenuPageState extends State<AturStockMenuPage> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = GlobalKey<ScaffoldState>();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MenuMakananBloc(
              categoryRepository: context.read<CategoryRepository>(),
            )..add(const GetMenuMakanan('0DzobjgsR7jF8qWvCoG0')),
          ),
          BlocProvider(
            create: (context) => ListMenuBloc(
              menuRepository: context.read<MenuRepository>(),
            ),
          ),
        ],
        child: Scaffold(
          //  key: _scaffold,
          appBar: AppBar(
            title: Text(widget.judul),
            backgroundColor: Colors.white,
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListMenuWidget()),
        ));
  }
}

class ListMenuWidget extends StatelessWidget {
  const ListMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.watch<MenuMakananBloc>().state.status;
    final oCcy = NumberFormat("#,##0.00", "IDR");
    
    if (status == MenuMakananStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (status == MenuMakananStatus.failure) {
      return const Center(
        child: Text('Terjadi kesalahan'),
      );
    } else if (status == MenuMakananStatus.success) {
      // final cat = categoryState.items.first;
      final cat = context.watch<MenuMakananBloc>().state.items!.first;
      context
          .read<ListMenuBloc>()
          .add(GetListMenu('merchant2', cat.categoryId!));
      return BlocBuilder<ListMenuBloc, ListMenuState>(
        builder: (context, state) {
          final status = state.status;

          if (status == ListMenuStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == ListMenuStatus.failure) {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          } else if (status == ListMenuStatus.success) {
            final items = state.items!;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  print(item.categoryId);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: CFColors.grayscaleBlack50,
                                  borderRadius: BorderRadius.circular(10.0),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 2,
                                  //     blurRadius: 10,
                                  //     offset: const Offset(
                                  //         5, 3), // changes position of shadow
                                  //   ),
                                  // ],
                                  image: DecorationImage(
                                      image: NetworkImage(item.image == null
                                          ? "https://i.pinimg.com/564x/94/17/82/941782f60e16a9d7f9b4cea4ae7025e0.jpg"
                                          : item.image.toString()),
                                      fit: BoxFit.fill)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 9),
                                      child: SizedBox(
                                        child: Text(
                                          item.name.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              // fontFamily: 'Raleway',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 9),
                                    child: Text(
                                      "Rp ${oCcy.format(item.price)}",
                                      style: TextStyle(
                                          color: CFColors.darkGrey,
                                          fontSize: 13,
                                          //fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Text(
                                    "1 Opsi Menu Terhubung",
                                    style: TextStyle(
                                        color: CFColors.greenAccent,
                                        fontSize: 13,
                                        //fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0, top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                        builder: (context) =>
                                            EditStok(menuModel: item),
                                      ))
                                      .then((value) => context
                                          .read<ListMenuBloc>()
                                          .add(GetListMenu(
                                              'merchant2', cat.categoryId!)));
                                },
                                child: Text(
                                  "Atur Stok",
                                  style: TextStyle(
                                      color: CFColors.redAccent,
                                      fontSize: 13,
                                      //fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                    color: CFColors.redAccent,
                                    fontSize: 13,
                                    //fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );
    }

    return const SizedBox.shrink();
  }
}
