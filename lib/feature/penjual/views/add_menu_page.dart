import 'package:flutter/material.dart';

class AddMenuPage extends StatelessWidget {
  const AddMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddMenuView();
  }
}

class AddMenuView extends StatefulWidget {
  const AddMenuView({Key? key}) : super(key: key);

  @override
  State<AddMenuView> createState() => _AddMenuViewState();
}

class _AddMenuViewState extends State<AddMenuView> {
  final _menuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _menuController,
              decoration: const InputDecoration(
                labelText: "Nama Menu",
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
  }
}
