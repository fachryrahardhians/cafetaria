import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penjual_repository/penjual_repository.dart';

class MenuCafetariaPage extends StatelessWidget {
  const MenuCafetariaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuMakananBloc(
        menuRepository: context.read<MenuRepository>(),
      )..add(const GetMenuMakanan('0DzobjgsR7jF8qWvCoG0')),
      child: const MenuCafetariaView(),
    );
  }
}

class MenuCafetariaView extends StatelessWidget {
  const MenuCafetariaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Cafetaria'),
      ),
      body: BlocBuilder<MenuMakananBloc, MenuMakananState>(
        builder: (context, state) {
          if (state is MenuMakananLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MenuMakananFailurre) {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          } else if (state is MenuMakananSuccess) {
            return Column(
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
                          label: Text(item.category),
                          selected: false,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: ElevatedButton(
        child: const Text('TAMBAH MENU ATAU KATEGORI'),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Tambah Menu Baru'),
                        onTap: () {
                          Navigator.pop(context);
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
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AddMenuPage()),
                          );
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
