import 'package:flutter/material.dart';

class MenuCafetariaPage extends StatelessWidget {
  const MenuCafetariaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MenuCafetariaView();
  }
}

class MenuCafetariaView extends StatelessWidget {
  const MenuCafetariaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElevatedButton(
        child: const Text('TAMBAH MENU ATAU KATEGORI'),
        onPressed: () {},
      ),
    );
  }
}
