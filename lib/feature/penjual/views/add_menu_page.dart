import 'package:cafetaria/feature/penjual/bloc/add_category_bloc/add_category_bloc.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMenuPage extends StatelessWidget {
  const AddMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryBloc(
        categoryRepository: context.read<CategoryRepository>(),
      ),
      child: const AddMenuView(),
    );
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
      backgroundColor: CFColors.grey,
      appBar: AppBar(
        title: const Text('TAMBAH KATEGORI MENU'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _ButtonSave(menuController: _menuController),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.04),
                  offset: Offset(0, 0),
                  blurRadius: 1,
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  offset: Offset(0, 0),
                  blurRadius: 4,
                ),
              ]),
              child: CFTextFormField(
                controller: _menuController,
                decoration: const InputDecoration(
                  labelText: "Nama Category",
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonSave extends StatelessWidget {
  const _ButtonSave({
    Key? key,
    required TextEditingController menuController,
  })  : _menuController = menuController,
        super(key: key);

  final TextEditingController _menuController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCategoryBloc, AddCategoryState>(
      listener: (context, state) {
        if (state is AddCategorySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category berhasil ditambahkan'),
            ),
          );
        } else if (state is AddCategoryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Terjadi kesalahan'),
            ),
          );
        }
      },
      builder: (context, state) {
        return CFButton.primary(
          child: (state is AddCategoryLoading)
              ? const CircularProgressIndicator()
              : const Text('SIMPAN'),
          onPressed: () {
            context.read<AddCategoryBloc>().add(SaveCategory(
                  category: _menuController.text,
                  idMerchant: '0DzobjgsR7jF8qWvCoG0',
                ));
          },
        );
      },
    );
  }
}
