import 'dart:async';
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
  final MenuModel? menu;
  const AddMenuPenjualPage({Key? key, this.menu}) : super(key: key);

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
      child: AddMenuPenjualView(menu: menu),
    );
  }
}

class AddMenuPenjualView extends StatefulWidget {
  final MenuModel? menu;
  const AddMenuPenjualView({Key? key, this.menu}) : super(key: key);

  @override
  State<AddMenuPenjualView> createState() => _AddMenuPenjualViewState();
}

class _AddMenuPenjualViewState extends State<AddMenuPenjualView> {
  bool showPhoto = false;
  bool loading = false;
  @override
  void initState() {
    if (widget.menu != null) {
      context
          .read<AddMenuPenjualBloc>()
          .add(MenuChange(widget.menu!.name.toString()));
      context
          .read<AddMenuPenjualBloc>()
          .add(DescriptionChange(widget.menu!.desc.toString()));
      context
          .read<AddMenuPenjualBloc>()
          .add(KategoriChange(widget.menu!.categoryId.toString()));
      context
          .read<AddMenuPenjualBloc>()
          .add(HargaJualChange(widget.menu!.price.toString()));
      for (var element in widget.menu!.tags!) {
        context.read<AddMenuPenjualBloc>().add(TageMenuChange(element));
        context.read<AddMenuPenjualBloc>().add(const AddTagMenu('dsf'));
      }
      context
          .read<AddMenuPenjualBloc>()
          .add(CheckedRecommendedMenu(widget.menu!.isRecomended!));
      context
          .read<AddMenuPenjualBloc>()
          .add(MenuCanBooked(widget.menu!.isPreOrder!));
      context
          .read<AddMenuPenjualBloc>()
          .add(CheckedFoodKit(widget.menu!.foodKit!));
    }
    super.initState();
  }

  bool checkButton(File? image, AddMenuPenjualState menuPenjualState) {
    if (showPhoto) {
      if (image != null &&
          menuPenjualState.menuInput.valid &&
          menuPenjualState.deskripsiInput.valid &&
          menuPenjualState.categoryInput.valid &&
          menuPenjualState.tagging.isNotEmpty)
        return true;
      else
        return false;
    } else if (menuPenjualState.menuInput.valid &&
        menuPenjualState.deskripsiInput.valid &&
        menuPenjualState.categoryInput.valid &&
        menuPenjualState.tagging.isNotEmpty)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    final _picker = ImagePicker();
    final listTagging =
        context.select((AddMenuPenjualBloc bloc) => bloc.state.tagging);
    final checkStock = context
        .select((AddMenuPenjualBloc bloc) => bloc.state.checkStockAccepted);
    final menuPenjualState =
        context.select((AddMenuPenjualBloc bloc) => bloc.state);

    final checkMenuRecomended = context.select(
        (AddMenuPenjualBloc bloc) => bloc.state.checkMenuRecomendAccepted);
    final checkBookedMenu = context.select(
        (AddMenuPenjualBloc bloc) => bloc.state.checkMenuBookedAccepted);
    final checkedFoodKit =
        context.select((AddMenuPenjualBloc bloc) => bloc.state.foodKit);
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
          Timer(
            const Duration(seconds: 3),
            () {
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        }
        if (state.uploadProgress?.status == UploadStatus.uploaded) {
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     const SnackBar(
          //       content: Text('Foto berhasil diupload'),
          //     ),
          //   );
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
            onPressed: checkButton(image, menuPenjualState)
                ? () {
                    setState(() {
                      loading = true;
                    });
                    if (widget.menu == null) {
                      context.read<AddMenuPenjualBloc>().add(SaveMenu());
                    } else {
                      context.read<AddMenuPenjualBloc>().add(UpdateMenu(
                          widget.menu!.image.toString(),
                          updatePhoto: showPhoto,
                          menuId: widget.menu!.menuId.toString()));
                    }
                  }
                : null,
            child: loading ? const Text('LOADING') : const Text('SIMPAN'),
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
                initialValue: widget.menu == null ? '' : widget.menu!.name,
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
                initialValue: widget.menu == null ? '' : widget.menu!.desc,
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
                      value: widget.menu == null
                          ? context.watch<MenuMakananBloc>().state.items![0]
                          : context.watch<MenuMakananBloc>().state.items![
                              context
                                  .watch<MenuMakananBloc>()
                                  .state
                                  .items!
                                  .indexWhere((element) =>
                                      element.categoryId ==
                                      widget.menu!.categoryId)],
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
                  ? Column(
                      children: [
                        IgnorePointer(
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
                                  initialValue: widget.menu == null
                                      ? ''
                                      : widget.menu!.price.toString(),
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
                        ),
                        IgnorePointer(
                          ignoring: !checkStock,
                          child: AnimatedOpacity(
                            opacity: checkStock == true ? 1.0 : 0.0,
                            duration: const Duration(seconds: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jumlah Stok',
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
                                    labelText: "Jumlah Stok",
                                  ),
                                  initialValue: widget.menu == null
                                      ? ''
                                      : widget.menu!.price.toString(),
                                  onChanged: (val) {
                                    context
                                        .read<AddMenuPenjualBloc>()
                                        .add(JumlahStokChange(val));
                                    // context.read<AddMenuPenjualBloc>().add(DescriptionChange(val));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                  ...listTagging.map((e) => Padding(
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
                                  e,
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
                                        .add(DeleteTag(e));
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
                      ))
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
              Visibility(
                visible: showPhoto,
                // ignore: sort_child_properties_last
                child: InkWell(
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
                replacement: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CFColors.grey30,
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            widget.menu == null
                                ? Container()
                                : Image.network(widget.menu!.image.toString()),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPhoto = true;
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
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
              Row(
                children: [
                  Checkbox(
                    value: checkedFoodKit,
                    onChanged: (val) {
                      context
                          .read<AddMenuPenjualBloc>()
                          .add(CheckedFoodKit(val!));
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Tambahkan alat makan',
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
