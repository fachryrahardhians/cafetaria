import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_repository/menu_repository.dart';

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
            indicatorColor: CFColors.redPrimary,
            indicatorWeight: 3,
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  context: context,
                  builder: (dialogContext) {
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
                                Navigator.pop(dialogContext);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AddMenuPage()),
                                );

                                context.read<MenuMakananBloc>().add(
                                    const GetMenuMakanan(
                                        '0DzobjgsR7jF8qWvCoG0'));
                              },
                              desc: 'mis : Ayam bakar, milk tea madu',
                            ),
                            const SizedBox(height: 10),
                            ListMenu(
                              title: 'Tambah Kategori Baru',
                              onTap: () {
                                Navigator.push(
                                  dialogContext,
                                  MaterialPageRoute(
                                      builder: (_) => const AddMenuPage()),
                                ).then(
                                  (value) {
                                    context.read<MenuMakananBloc>().add(
                                        const GetMenuMakanan(
                                            '0DzobjgsR7jF8qWvCoG0'));
                                    Navigator.pop(dialogContext);
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
                  });
            },
          ),
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
          .add(GetListMenu('0DzobjgsR7jF8qWvCoG0', cat.categoryId!));
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
