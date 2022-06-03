import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
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
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.category),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: ElevatedButton(
        child: const Text('TAMBAH MENU ATAU KATEGORI'),
        onPressed: () {},
      ),
    );
  }
}
