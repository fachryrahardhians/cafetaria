import 'package:cafetaria/feature/penjual/bloc/add_category_bloc/add_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penjual_repository/penjual_repository.dart';

class AddMenuPage extends StatelessWidget {
  const AddMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryBloc(
        menuRepository: context.read<MenuRepository>(),
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _menuController,
              decoration: const InputDecoration(
                labelText: "Nama Category",
              ),
            ),
            BlocConsumer<AddCategoryBloc, AddCategoryState>(
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
                return ElevatedButton(
                  onPressed: () {
                    context.read<AddCategoryBloc>().add(SaveCategory(
                          category: _menuController.text,
                          idMerchant: '0DzobjgsR7jF8qWvCoG0',
                        ));
                  },
                  child: (state is AddCategoryLoading)
                      ? const CircularProgressIndicator()
                      : const Text('SIMPAN'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
