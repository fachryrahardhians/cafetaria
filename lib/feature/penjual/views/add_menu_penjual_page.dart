import 'dart:io';

import 'package:cafetaria/feature/penjual/bloc/add_menu_penjual_bloc/add_menu_penjual_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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

    // final menuValid = context.select((AddMenuPenjualBloc bloc) =>
    //     bloc.state.menuInput.pure ||
    //     (!bloc.state.menuInput.pure && bloc.state.menuInput.valid));

    // print(image);

    return BlocListener<AddMenuPenjualBloc, AddMenuPenjualState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Menu berhasil ditambahkan'),
              ),
            );
        }
        if (state.uploadProgress?.status == UploadStatus.uploaded) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Foto berhasil diupload'),
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'TAMBAH MENU',
          ),
        ),
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
                    Navigator.of(context).pop();
                  }
                : null,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              Text(
                'NAMA MENU',
                style: TextStyle(
                  color: CFColors.grayscaleBlack80,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
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
              Text(
                'DESKRIPSI MENU',
                style: TextStyle(
                  color: CFColors.grayscaleBlack80,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CFTextFormField(
                decoration: const InputDecoration(
                  labelText: "Deskripsi Menu",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (val) {
                  context
                      .read<AddMenuPenjualBloc>()
                      .add(DescriptionChange(val));
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'KATEGORI MENU',
                style: TextStyle(
                  color: CFColors.grayscaleBlack80,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
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
                            .add(KategoriChange(val!.categoryId.toString()));
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
                      context
                          .read<AddMenuPenjualBloc>()
                          .add(CheckedStock(val!));
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Harga Jual',
                              style: TextStyle(
                                color: CFColors.grayscaleBlack80,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CFTextFormField(
                              decoration: const InputDecoration(
                                labelText: "Harga Jual",
                              ),
                              onChanged: (val) {
                                context
                                    .read<AddMenuPenjualBloc>()
                                    .add(HargaJualChange(val));
                                // context.read<AddMenuPenjualBloc>().add(DescriptionChange(val));
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              // const SizedBox(
              //   height: 16,
              // ),
              // CFTextFormField(
              //   decoration: const InputDecoration(
              //     labelText: "Harga",
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey),
              //     ),
              //   ),
              //   onChanged: (val) {
              //     context.read<AddMenuPenjualBloc>().add(HargaJualChange(val));
              //   },
              // ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'TAGGING',
                style: TextStyle(
                  color: CFColors.grayscaleBlack80,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: CFColors.redPrimary40,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tag,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<AddMenuPenjualBloc>()
                                      .add(DeleteTag(tag));
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),
              Text(
                'FOTO MENU',
                style: TextStyle(
                  color: CFColors.grayscaleBlack80,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),

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
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CFColors.grey30,
                    ),
                    child: image != null
                        ? Center(
                            child: Stack(
                              children: [
                                Image.file(image),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<AddMenuPenjualBloc>()
                                          .add(DeleteImage());
                                    },
                                    child: const Icon(
                                      Icons.close,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.upload_file,
                                size: 36,
                              ),
                              SizedBox(
                                height: 5.5,
                              ),
                              Text('UNGGAH FOTO'),
                            ],
                          ),
                  ),
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
                  Text(
                    'Menu yang direkomendasikan',
                    style: TextStyle(
                      color: CFColors.slateGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                      context
                          .read<AddMenuPenjualBloc>()
                          .add(MenuCanBooked(val!));
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Menu bisa dibooking',
                    style: TextStyle(
                      color: CFColors.slateGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
