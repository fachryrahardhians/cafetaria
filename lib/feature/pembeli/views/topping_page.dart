import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/menu_in_cart_bloc/menu_in_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:option_menu_repository/option_menu_repository.dart';

import '../../penjual/bloc/list_opsi_menu_bloc/list_opsi_menu_bloc.dart';

enum type { sama, beda }

class SelectToppingPage extends StatelessWidget {
  final MenuModel model;
  final Keranjang itemInKeranjang;
  const SelectToppingPage(
      {Key? key, required this.model, required this.itemInKeranjang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectTopping(
      item: model,
      itemInKeranjang: itemInKeranjang,
    );
  }
}

class SelectTopping extends StatefulWidget {
  final MenuModel item;
  final Keranjang itemInKeranjang;
  const SelectTopping(
      {Key? key, required this.item, required this.itemInKeranjang})
      : super(key: key);

  @override
  State<SelectTopping> createState() => _SelectToppingState(item);
}

class _SelectToppingState extends State<SelectTopping> {
  type? _toppingType = type.sama;
  MenuModel item;
  _SelectToppingState(this.item);
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _counterController = TextEditingController();
  List<OptionMenuModel> optionmenu = [];
  List<Option> optionPilih = [];
  late AddMenuToCartBloc addMenuToCartBloc;
  late MenuInCartBloc menuInCartBloc;
  late ListOpsiMenuBloc listOpsiMenuBloc;
  int qty = 0;
  bool _isButtonPerbaruEnable = true;
  bool value = false;
  @override
  void initState() {
    addMenuToCartBloc =
        AddMenuToCartBloc(menuRepository: context.read<MenuRepository>());
    menuInCartBloc =
        MenuInCartBloc(menuRepository: context.read<MenuRepository>());
    listOpsiMenuBloc = ListOpsiMenuBloc(
        optionMenuRepository: context.read<OptionMenuRepository>())
      ..add(GetListOpsiMenu(item.menuId.toString()));
    if (widget.itemInKeranjang.quantity == -1) {
      qty = 0;
    } else {
      qty = widget.itemInKeranjang.quantity;
    }

    _counterController.text = qty.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? total;
    if (widget.itemInKeranjang.quantity == qty ||
        (widget.itemInKeranjang.quantity == -1 && qty == 0)) {
      _isButtonPerbaruEnable = false;
    } else {
      _isButtonPerbaruEnable = true;
    }
    if (widget.itemInKeranjang.options != null) {
      total = widget.itemInKeranjang.options!.length;
    }
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => addMenuToCartBloc),
          ),
          BlocProvider(
            create: ((context) => menuInCartBloc),
          ),
          BlocProvider(
            create: ((context) => listOpsiMenuBloc),
          )
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<AddMenuToCartBloc, AddMenuToCartState>(
                  listener: ((context, state) {
                if (state is MenuAddedToTheCart) {
                  Navigator.pop(context);
                }
              })),
              BlocListener<MenuInCartBloc, MenuInCartState>(
                  listener: ((context, state) {
                if (state is MenuInCartDeleted) {
                  Navigator.pop(context);
                }

                if (state is MenuInCartUpdated) {
                  Navigator.pop(context);
                }
              })),
              BlocListener<ListOpsiMenuBloc, ListOpsiMenuState>(
                  listener: (context, state) {
                final status = state.status;
                if (status == ListOpsiMenuStatus.loading) {
                  print("loading");
                } else if (status == ListOpsiMenuStatus.failure) {
                  print('Terjadi kesalahan');
                } else if (status == ListOpsiMenuStatus.success) {
                  setState(() {
                    optionmenu = state.items!;
                  });
                }
              })
            ],
            child: SafeArea(
              child: Scaffold(
                backgroundColor: const Color(0xffFCFBFC),
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Color(0xffee3124)),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    item.name.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff333435)),
                  ),
                  leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.clear_rounded)),
                  centerTitle: true,
                ),
                body: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  children: [
                    _menuInfo(),
                    SizedBox(height: SizeConfig.safeBlockVertical * 2),
                    optionmenu.isEmpty
                        ? const SizedBox()
                        : Text(
                            'topping ${total}',
                            style: normalText.copyWith(fontSize: 14),
                          ),
                    optionmenu.isEmpty
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<type>(
                                      value: type.sama,
                                      groupValue: _toppingType!,
                                      onChanged: (type? value) {
                                        setState(() {
                                          _toppingType = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 3),
                                    const Text('Topping Sama')
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<type>(
                                      value: type.beda,
                                      groupValue: _toppingType!,
                                      onChanged: (type? value) {
                                        setState(() {
                                          _toppingType = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 3),
                                    const Text('Topping Beda')
                                  ],
                                ),
                              )
                            ],
                          ),
                    optionmenu.isEmpty
                        ? const SizedBox(
                            height: 150,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index == 0 ||
                                  index == optionmenu.length + 1) {
                                return const SizedBox.shrink();
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: optionmenu[index - 1].option.length,
                                itemBuilder: (context, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      optionPilih
                                          .add(optionmenu[index - 1].option[i]);

                                      print(optionPilih);
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            value: value,
                                            onChanged: (newValue) {
                                              setState(() {
                                                value = newValue!;
                                              });
                                              //print(value);
                                            }),
                                        SizedBox(
                                            width:
                                                SizeConfig.safeBlockHorizontal *
                                                    2),
                                        Text(
                                          optionmenu[index - 1].option[i].name,
                                          style:
                                              normalText.copyWith(fontSize: 15),
                                        ),
                                        const Spacer(),
                                        Text(
                                          optionmenu[index - 1]
                                              .option[i]
                                              .price
                                              .toString(),
                                          style:
                                              normalText.copyWith(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
                                  child: Text(optionmenu[index].title),
                                ),
                            itemCount: 1 + optionmenu.length),
                    Text(
                      'CATATAN UNTUK PENJUAL',
                      style: normalText.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff5C5E61).withOpacity(.8)),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 1),
                    catatan(),
                    SizedBox(height: SizeConfig.safeBlockVertical * 2),
                    quantity(),
                  ],
                ),
                bottomNavigationBar: bottomNavBar(),
              ),
            )));
  }

  Widget _menuInfo() {
    var formatter = NumberFormat('Rp #,##,000');
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: boxShadows),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'itemId1',
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.safeBlockVertical * 20,
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                item.image.toString(),
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name.toString()),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                Text(formatter.format(item.price)),
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 70,
                  child: Text(item.desc.toString()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget topping(Option option) {
  //   bool value = false;
  //   return Row(
  //     children: [
  //       Checkbox(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //           value: value,
  //           onChanged: (newValue) {
  //             setState(() {
  //               value = newValue!;
  //             });
  //             //print(value);
  //           }),
  //       SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
  //       Text(
  //         option.name,
  //         style: normalText.copyWith(fontSize: 15),
  //       ),
  //       const Spacer(),
  //       Text(
  //         option.price.toString(),
  //         style: normalText.copyWith(fontSize: 15),
  //       )
  //     ],
  //   );
  // }

  // Widget listTopping() {
  //   return ListView.separated(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         return ListView.builder(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: optionmenu[index].option.length,
  //           itemBuilder: (context, i) {
  //             return topping(optionmenu[index].option[i]);
  //           },
  //         );
  //       },
  //       separatorBuilder: (context, index) => SizedBox(
  //             height: SizeConfig.safeBlockVertical * 2,
  //             child: Text(optionmenu[index].title),
  //           ),
  //       itemCount: optionmenu.length);
  // }

  Widget catatan() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 1,
            color: Colors.black.withOpacity(.04)),
        BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 4,
            color: Colors.black.withOpacity(.08))
      ]),
      child: TextFormField(
        controller: _catatanController,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 16),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          hintText: "Masukkan catatan untuk penjual",
          hintStyle: const TextStyle(fontSize: 13, color: Color(0xffCACCCF)),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        minLines: 4,
        maxLines: 5,
      ),
    );
  }

  Widget quantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.safeBlockHorizontal * 10,
          height: SizeConfig.safeBlockHorizontal * 10,
          decoration: BoxDecoration(
              color: const Color(0xffee3124),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: GestureDetector(
                onTap: () {
                  if (qty != 0) {
                    setState(() {
                      qty--;
                      _counterController.text = qty.toString();
                    });
                  }
                },
                child: const Icon(
                  Icons.remove_rounded,
                  color: Colors.white,
                )),
          ),
        ),
        SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
        Container(
          width: SizeConfig.safeBlockHorizontal * 20,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 1,
                color: Colors.black.withOpacity(.04)),
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 4,
                color: Colors.black.withOpacity(.08))
          ]),
          child: TextFormField(
            keyboardType: TextInputType.number,
            autofocus: false,
            controller: _counterController,
            maxLength: 3,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) {
              setState(() {
                qty = int.parse(value);
              });
            },
          ),
        ),
        SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
        Container(
          width: SizeConfig.safeBlockHorizontal * 10,
          height: SizeConfig.safeBlockHorizontal * 10,
          decoration: BoxDecoration(
              color: const Color(0xffee3124),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: GestureDetector(
                onTap: () => setState(() {
                      qty++;
                      _counterController.text = qty.toString();
                    }),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }

  Widget bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.safeBlockVertical * 6.5,
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    _isButtonPerbaruEnable
                        ? const Color(0xffee3124)
                        : const Color(0xffFE8F7D)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none))),
            onPressed: _isButtonPerbaruEnable
                ? () {
                    if (qty == 0) {
                      menuInCartBloc
                          .add(DeleteMenuInCart(widget.itemInKeranjang));
                    } else if (widget.itemInKeranjang.quantity == -1) {
                      addMenuToCartBloc.add(AddMenuToCart(
                          option: optionPilih,
                          menuModel: item,
                          quantity: qty,
                          totalPrice: (item.price ?? 0) * qty,
                          notes: _catatanController.text));
                    } else {
                      Keranjang editedMenu = widget.itemInKeranjang;
                      //deklarasi isi menu in keranjang yang akan di update
                      editedMenu.totalPrice =
                          widget.itemInKeranjang.price! * qty;
                      editedMenu.quantity = qty;
                      editedMenu.options = optionPilih.map((e) {
                        return ListOption(
                            name: e.name, price: e.price.toString());
                      }).toList();
                      menuInCartBloc.add(UpdateMenuInCart(editedMenu));
                    }
                  }
                : null,
            child: Text('Perbarui Isi Keranjang',
                style: normalText.copyWith(fontSize: 14, color: Colors.white))),
      ),
    );
  }
}
