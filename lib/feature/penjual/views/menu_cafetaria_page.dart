import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penjual_repository/penjual_repository.dart';

class MenuCafetariaPage extends StatelessWidget {
  const MenuCafetariaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MenuMakananBloc(
            menuRepository: context.read<MenuRepository>(),
          )..add(const GetMenuMakanan('0DzobjgsR7jF8qWvCoG0')),
        ),
        BlocProvider(
          create: (context) => ListMenuBloc(
            menuRepository: context.read<MenuRepository>(),
          ),
        ),
      ],
      child: const MenuCafetariaView(),
    );
  }
}

class MenuCafetariaView extends StatelessWidget {
  const MenuCafetariaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffold = GlobalKey();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffold,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Text(
                  'Daftar Menu',
                  style: GoogleFonts.ubuntu(
                    color: const Color(0xff2E3032),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'Opsi Menu',
                  style: GoogleFonts.ubuntu(
                    color: const Color(0xffC8CCD2),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'Tidak Tersedia',
                  style: GoogleFonts.ubuntu(
                    color: const Color(0xffC8CCD2),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Menu Cafetaria',
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<MenuMakananBloc, MenuMakananState>(
              builder: (context, state) {
                print(state);
                if (state is MenuMakananLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MenuMakananFailurre) {
                  return const Center(
                    child: Text('Terjadi kesalahan'),
                  );
                } else if (state is MenuMakananSuccess) {
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
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              final item = state.items[index];
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
            const ListMenuWidget()
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              primary: const Color(0xffEA001E),
            ),
            child: const Text('TAMBAH MENU ATAU KATEGORI'),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (dialogContext) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Tambah Menu Baru'),
                            onTap: () {
                              Navigator.pop(dialogContext);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AddMenuPage()),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            title: const Text('Tambah Kategori Baru'),
                            onTap: () async {
                              Navigator.push(
                                dialogContext,
                                MaterialPageRoute(
                                    builder: (_) => const AddMenuPage()),
                              ).then((value) {
                                context.read<MenuMakananBloc>().add(
                                    const GetMenuMakanan(
                                        '0DzobjgsR7jF8qWvCoG0'));
                                Navigator.pop(dialogContext);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
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
    final categoryState = context.watch<MenuMakananBloc>().state;

    if (categoryState is MenuMakananLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (categoryState is MenuMakananFailurre) {
      return const Center(
        child: Text('Terjadi kesalahan'),
      );
    } else if (categoryState is MenuMakananSuccess) {
      final cat = categoryState.items.first;
      context
          .read<ListMenuBloc>()
          .add(GetListMenu('0DzobjgsR7jF8qWvCoG0', cat.categoryId!));
      return BlocBuilder<ListMenuBloc, ListMenuState>(
        builder: (context, state) {
          if (state is ListMenuLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListMenuFailure) {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          } else if (state is ListMenuSuccess) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    title: Text(item.nama ?? '-'),
                    // subtitle: Text(item.price.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // context.read<ListMenuBloc>().add(DeleteListMenu(item));
                      },
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
