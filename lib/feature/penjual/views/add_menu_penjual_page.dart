import 'dart:io';

import 'package:cafetaria/feature/penjual/bloc/add_menu_penjual_bloc/add_menu_penjual_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_repository/menu_repository.dart';

class AddMenuPenjualPage extends StatelessWidget {
  const AddMenuPenjualPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddMenuPenjualBloc(
            cloudStorage: context.read<CloudStorage>(),
            menuRepository: context.read<MenuRepository>(),
          ),
        ),

        /// TODO(@Burhan): id merchant still hardcode
        BlocProvider(
          create: (context) => MenuMakananBloc(
            categoryRepository: context.read<CategoryRepository>(),
          )..add(const GetMenuMakanan('0DzobjgsR7jF8qWvCoG0')),
        ),
      ],
      child: const AddMenuPenjualView(),
    );
  }
}

class AddMenuPenjualView extends StatelessWidget {
  const AddMenuPenjualView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _picker = ImagePicker();
    final menuPenjualState =
        context.select((AddMenuPenjualBloc bloc) => bloc.state);
    final listTagging =
        context.select((AddMenuPenjualBloc bloc) => bloc.state.tagging);

    final checkStock = context
        .select((AddMenuPenjualBloc bloc) => bloc.state.checkStockAccepted);
    final checkMenuRecomended = context.select(
        (AddMenuPenjualBloc bloc) => bloc.state.checkMenuRecomendAccepted);
    final checkBookedMenu = context.select(
        (AddMenuPenjualBloc bloc) => bloc.state.checkMenuBookedAccepted);

    final image = context.select((AddMenuPenjualBloc bloc) => bloc.state.image);

    final uploadProgressState =
        context.select((AddMenuPenjualBloc bloc) => bloc.state.uploadProgress);

    final menuValid = context.select((AddMenuPenjualBloc bloc) =>
        bloc.state.menuInput.pure ||
        (!bloc.state.menuInput.pure && bloc.state.menuInput.valid));

    return Scaffold(
      backgroundColor: CFColors.grey,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CFButton.primary(
          child: const Text('SIMPAN'),
          onPressed: menuPenjualState.menuInput.valid &&
                  menuPenjualState.deskripsiInput.valid &&
                  menuPenjualState.categoryInput.valid &&
                  menuPenjualState.tagging.isNotEmpty
              ? () {
                  context.read<AddMenuPenjualBloc>().add(SaveMenu());
                }
              : null,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            CFTextFormField(
              decoration: const InputDecoration(
                labelText: "Nama Menu",
              ),
              onChanged: (val) {
                context.read<AddMenuPenjualBloc>().add(MenuChange(val));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CFTextFormField(
              decoration: const InputDecoration(
                labelText: "Deskripsi Menu",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (val) {
                context.read<AddMenuPenjualBloc>().add(DescriptionChange(val));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            context.watch<MenuMakananBloc>().state.status ==
                    MenuMakananStatus.success
                ? DropdownButtonFormField<CategoryModel>(
                    items: context
                        .watch<MenuMakananBloc>()
                        .state
                        .items!
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.category),
                            ))
                        .toList(),
                    onChanged: (val) {
                      context
                          .read<AddMenuPenjualBloc>()
                          .add(KategoriChange(val!.category));
                    },
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Checkbox(
                  value: checkStock,
                  onChanged: (val) {
                    context.read<AddMenuPenjualBloc>().add(CheckedStock(val!));
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Stok'),
              ],
            ),
            checkStock
                ? const SizedBox(
                    height: 13,
                  )
                : const SizedBox.shrink(),
            checkStock
                ? IgnorePointer(
                    ignoring: !checkStock,
                    child: AnimatedOpacity(
                      opacity: checkStock == true ? 1.0 : 0.0,
                      duration: const Duration(seconds: 3),
                      child: CFTextFormField(
                        decoration: const InputDecoration(
                          labelText: "Harga Jual",
                        ),
                        onChanged: (val) {
                          // context.read<AddMenuPenjualBloc>().add(DescriptionChange(val));
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 16,
            ),
            CFTextFormField(
              decoration: const InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (val) {
                context.read<AddMenuPenjualBloc>().add(HargaJualChange(val));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CFTextFormField(
                      decoration: const InputDecoration(
                        labelText: "Tagging",
                      ),
                      onChanged: (val) {
                        context
                            .read<AddMenuPenjualBloc>()
                            .add(TageMenuChange(val));
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CFButton.primary(
                    child: const Text('Tambahkan'),
                    onPressed: () {
                      context
                          .read<AddMenuPenjualBloc>()
                          .add(const AddTagMenu('dsf'));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
              children: [
                for (var tag in listTagging)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tag),
                  ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Foto Menu'),
            InkWell(
              onTap: () async {
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  context.read<AddMenuPenjualBloc>().add(
                        ChoosePhoto(File(image.path)),
                      );
                }
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
                child:
                    image != null ? Image.file(image) : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            uploadProgressState != null
                ? uploadProgressState.status == UploadStatus.uploading
                    ? LinearProgressIndicator(
                        value: uploadProgressState.uploadPercentage!,
                      )
                    : const SizedBox.shrink()
                : const SizedBox.shrink(),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Checkbox(
                  value: checkMenuRecomended,
                  onChanged: (val) {
                    context
                        .read<AddMenuPenjualBloc>()
                        .add(CheckedRecommendedMenu(val!));
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Menu yang direkomendasikan'),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Checkbox(
                  value: checkBookedMenu,
                  onChanged: (val) {
                    context.read<AddMenuPenjualBloc>().add(MenuCanBooked(val!));
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Menu bisa dibooking'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
