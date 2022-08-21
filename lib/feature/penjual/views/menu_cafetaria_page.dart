import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/opsi_menu_makanan_bloc/opsi_menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_penjual_page.dart';
import 'package:cafetaria/feature/penjual/views/add_opsi_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/atur_stock_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/add_stock_menu.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:option_menu_repository/option_menu_repository.dart';

class MenuCafetariaPage extends StatelessWidget {
  const MenuCafetariaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
         BlocProvider(
          create: (context) => OpsiMenuMakananBloc(
            opsimenuRepository: context.read<OptionMenuRepository>(),
          )..add(const GetOpsiMenuMakanan('0DzobjgsR7jF8qWvCoG0')),
        ),
      ],
      child: const MenuCafetariaView(),
    );
  }
}

class MenuCafetariaView extends StatefulWidget {
  const MenuCafetariaView({Key? key}) : super(key: key);

  @override
  State<MenuCafetariaView> createState() => _MenuCafetariaViewState();
}

class _MenuCafetariaViewState extends State<MenuCafetariaView> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = GlobalKey<ScaffoldState>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffold,
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: CFColors.redPrimary,
            indicatorWeight: 3,
            unselectedLabelColor: const Color(0xffC8CCD2),
            labelColor: const Color(0xff2E3032),
            unselectedLabelStyle: GoogleFonts.ubuntu(
              color: const Color(0xffC8CCD2),
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            labelStyle: GoogleFonts.ubuntu(
              color: const Color(0xff2E3032),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                child: Text(
                  'Daftar Menu',
                ),
              ),
              Tab(
                child: Text(
                  'Opsi Menu',
                ),
              ),
              Tab(
                child: Text(
                  'Tidak Tersedia',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Menu Cafetaria',
          ),
        ),
        body: const TabBarView(
          children: [
            DaftarMenuWidget(),
            OpsiMenuWidget(),
            ListMenuTidakTersediaWidget(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          height: 74,
          child: const TabBarView(
            children: [
              BottomDaftarMenuWidget(),
              BottomOpsiMenuWidget(),
              SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class DaftarMenuWidget extends StatelessWidget {
  const DaftarMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MenuMakananBloc, MenuMakananState>(
          builder: (context, state) {
            final status = state.status;

            if (status == MenuMakananStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (status == MenuMakananStatus.failure) {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            } else if (status == MenuMakananStatus.success) {
              final items = state.items!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      // width: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ChoiceChip(
                              padding: const EdgeInsets.all(9),
                              onSelected: (val) {
                                context.read<ListMenuBloc>().add(
                                      GetListMenu('0DzobjgsR7jF8qWvCoG0',
                                          item.categoryId!),
                                    );
                              },
                              label: Text(
                                item.category,
                                style: GoogleFonts.ubuntu(
                                    color: const Color(0xffEA001E)),
                              ),
                              side: const BorderSide(
                                color: Color(0xffEA001E),
                              ),
                              selected: false,
                              backgroundColor: const Color(0xffFEDED8),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const ListMenuWidget(),
      ],
    );
  }
}

class _ModalBottomSheet extends StatelessWidget {
  const _ModalBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xffE5E6E6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 10),
            ListMenu(
              title: 'Tambah Menu Baru',
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddMenuPage()),
                );
                Navigator.pop(context);
              },
              desc: 'mis : Ayam bakar, milk tea madu',
            ),
            const SizedBox(height: 10),
            ListMenu(
              title: 'Tambah Kategori Baru',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddMenuPenjualPage()),
                ).then(
                  (value) {
                    // context
                    //     .read<MenuMakananBloc>()
                    //     .add(const GetMenuMakanan('0DzobjgsR7jF8qWvCoG0'));
                    // Navigator.pop(context);
                  },
                );
              },
              desc: 'mis : Ayam, ikan, minuman',
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class ListMenu extends StatelessWidget {
  const ListMenu({
    Key? key,
    required this.onTap,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              offset: Offset(0, 4),
              blurRadius: 12,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Assets.images.maskgroup.image(
                width: 64,
                height: 64,
              ),
              const SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: CFColors.darkGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      color: CFColors.slateGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
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
            return Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  // return ListTile(
                  //   title: Text(item.name ?? '-'),
                  //   // subtitle: Text(item.price.toString()),
                  //   trailing: IconButton(
                  //     icon: const Icon(Icons.delete),
                  //     onPressed: () {
                  //       // context.read<ListMenuBloc>().add(DeleteListMenu(item));
                  //     },
                  //   ),
                  // );
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Rp ${oCcy.format(item.price)}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          '1 opsi menu tersambung',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditStok(menuModel: item),
                                  ),
                                ).then((value) => context
                                    .read<ListMenuBloc>()
                                    .add(GetListMenu(
                                        'merchant2', cat.categoryId!)));
                              },
                              child: const Text(
                                'Atur Stok',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            InkWell(
                              onTap: () {},
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

class ListMenuTidakTersediaWidget extends StatelessWidget {
  const ListMenuTidakTersediaWidget({
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
          .add(GetListMenuTidakTersedia('merchant2', cat.categoryId!));
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
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    // return ListTile(
                    //   title: Text(item.name ?? '-'),
                    //   // subtitle: Text(item.price.toString()),
                    //   trailing: IconButton(
                    //     icon: const Icon(Icons.delete),
                    //     onPressed: () {
                    //       // context.read<ListMenuBloc>().add(DeleteListMenu(item));
                    //     },
                    //   ),
                    // );
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Rp ${oCcy.format(item.price)}',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Jumlah Stok ${item.stock}',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     InkWell(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 EditStok(menuModel: item),
                          //           ),
                          //         ).then((value) => context
                          //             .read<ListMenuBloc>()
                          //             .add(GetListMenu(
                          //                 'merchant2', cat.categoryId!)));
                          //       },
                          //       child: const Text(
                          //         'Atur Stok',
                          //         style: TextStyle(
                          //           color: Colors.red,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 16.0),
                          //     InkWell(
                          //       onTap: () {},
                          //       child: const Text(
                          //         'Edit',
                          //         style: TextStyle(
                          //           color: Colors.red,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  },
                ),
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

class BottomDaftarMenuWidget extends StatelessWidget {
  const BottomDaftarMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(44),
        primary: const Color(0xffEA001E),
      ),
      child: const Text('TAMBAH MENU ATAU KATEGORI'),
      onPressed: () async {
        await showModalBottomSheet(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          context: context,
          builder: (context) {
            return const _ModalBottomSheet();
          },
        );
        context
            .read<MenuMakananBloc>()
            .add(const GetMenuMakanan('0DzobjgsR7jF8qWvCoG0'));
      },
    );
  }
}



class OpsiMenuWidget extends StatefulWidget {
  const OpsiMenuWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OpsiMenuWidgetState();
}

class _OpsiMenuWidgetState extends State<OpsiMenuWidget> {
  List<OptionMenuModel> menuOptions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<OpsiMenuMakananBloc, OpsiMenuMakananState>(
          builder: (context, state) {
            final status = state.status;

            if (status == OpsiMenuMakananStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (status == OpsiMenuMakananStatus.failure) {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            } else if (status == OpsiMenuMakananStatus.success) {
              final items = state.items!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      // width: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ChoiceChip(
                              padding: const EdgeInsets.all(9),
                              onSelected: (val) {
                                context.read<ListMenuBloc>().add(
                                      GetListMenu('0DzobjgsR7jF8qWvCoG0',
                                          item.categoryId!),
                                    );
                              },
                              label: Text(
                               ' items.category',
                                style: GoogleFonts.ubuntu(
                                    color: const Color(0xffEA001E)),
                              ),
                              side: const BorderSide(
                                color: Color(0xffEA001E),
                              ),
                              selected: false,
                              backgroundColor: const Color(0xffFEDED8),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const ListMenuWidget()
      ],
    );
  }

  Widget _itemOpsiMenuWidget(OptionMenuModel menu) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
        '  menu.title',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          // '${menu.option.map((e) => e.name)}',
          'test',
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          '0 menu tersambung',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: const Text(
                'Sambungkan',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Hapus',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AddOpsiMenuPage(),
                    //     settings: RouteSettings(
                    //       arguments: OpsiMenu(
                    //         menu.isMandatory,
                    //         menu.isMultipleTopping,
                    //         menu.menuId,
                    //         menu.option,
                    //         menu.optionmenuId,
                    //         menu.title,
                    //       ),
                    //     ),
                    //   ),
                    // ).then((value) {
                    //   if (value != null) {
                    //     // save to firebase
                    //   }
                    // });
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
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class BottomOpsiMenuWidget extends StatelessWidget {
  const BottomOpsiMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddOpsiMenuPage(),
            settings: const RouteSettings(
              arguments: null,
            ),
          ),
        ).then((value) {});
      },
      child: Text("Tambah Opsi Menu".toUpperCase()),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(44),
        primary: const Color(0xffEA001E),
      ),
    );
  }
}
