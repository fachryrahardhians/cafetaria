import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_read_bloc/menu_read_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_opsi_menu_page.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';

class ChooseMenuPage extends StatelessWidget {
  final String? id;
  const ChooseMenuPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => MenuReadBloc(
          menuRepository: context.read<MenuRepository>(),
        )..add(GetMenuRead(id.toString())),
      )
    ], child: const MenuPage());
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final oCcy = NumberFormat("#,##0.00", "IDR");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PILIH MENU'),
        iconTheme: const IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocBuilder<MenuReadBloc, MenuReadState>(
          builder: (context, state) {
            final status = state.status;
            if (status == MenuReadStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (status == MenuReadStatus.failure) {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            } else if (status == MenuReadStatus.success) {
              final items = state.items!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefix: const Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/info.png'),
                        const SizedBox(width: 8.0),
                        const Text(
                          'Pilih menu yang ingin ditambah opsi menu',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
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
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddOpsiMenuPage(
                                      menuId: items[index].menuId.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: CFColors.grayscaleBlack50,
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              image: DecorationImage(
                                                  image: NetworkImage(items[
                                                                  index]
                                                              .image ==
                                                          null
                                                      ? "https://i.pinimg.com/564x/94/17/82/941782f60e16a9d7f9b4cea4ae7025e0.jpg"
                                                      : items[index]
                                                          .image
                                                          .toString()),
                                                  fit: BoxFit.fill)),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              items[index].name.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                                "Rp ${oCcy.format(items[index].price)}"),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    items[index].options!.isEmpty
                                        ? const SizedBox()
                                        : const Text(
                                            'Opsi menu:',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                    const SizedBox(height: 4.0),
                                    // ListView.builder
                                    SizedBox(
                                      height: 70,
                                      child: ListView.builder(
                                        itemCount: items[index].options?.length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  items[index]
                                                      .options![i]
                                                      .title
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                // ListView.builder
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: SizedBox(
                                                    height: 16,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: items[index]
                                                          .options?[i]
                                                          .option
                                                          ?.length,
                                                      itemBuilder:
                                                          (context, length) {
                                                        return Text(
                                                          " ${items[index].options![i].option![length].name.toString()}, ",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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
}

class ListOpsiMenuPage extends StatefulWidget {
  const ListOpsiMenuPage({Key? key, this.menu}) : super(key: key);
  final MenuModel? menu;

  @override
  State<StatefulWidget> createState() => _ListOpsiMenuState();
}

class _ListOpsiMenuState extends State<ListOpsiMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opsi Menu ${widget.menu?.name.toString()}'.toUpperCase()),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/no-menu.png'),
              Text(
                'Anda belum memiliki opsi menu untuk ${widget.menu?.name}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddOpsiMenuPage(
                  menuId: '',
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            minimumSize: const Size.fromHeight(44),
          ),
          child: const Text(
            'TAMBAH OPSI MENU',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
