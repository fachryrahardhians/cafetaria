import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/menu_in_cart_bloc/menu_in_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/model/topping_pick.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';

import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:order_repository/order_repository.dart';

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
  List<Option>? optionPilih = [];
  List<OrderTopping>? optionPilihMultiple = [];
  List<ToopingPick>? topping = [];

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
    if (widget.itemInKeranjang.options != null) {
      optionPilih?.addAll(widget.itemInKeranjang.options!.map((e) {
        return Option(name: e.name!, price: int.parse(e.price!));
      }).toList());
    }
    if (widget.itemInKeranjang.toppings != null) {
      optionPilihMultiple?.addAll(widget.itemInKeranjang.toppings!.map((e) {
        return OrderTopping(
            items: e.items!.map((a) {
          return ToppingItem(
              name: a.name, price: int.parse(a.price.toString()));
        }).toList());
      }).toList());
    }

    _counterController.text = qty.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.itemInKeranjang.quantity == -1) && qty == 0) {
      _isButtonPerbaruEnable = false;
    } else {
      _isButtonPerbaruEnable = true;
    }
    if (widget.itemInKeranjang.options != null) {
      //print(widget.itemInKeranjang.options!.length);
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
                            'topping',
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
                    if (_toppingType == type.sama)
                      if (optionmenu.isEmpty)
                        const SizedBox(
                          height: 150,
                        )
                      else
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index == 0 ||
                                  index == optionmenu.length + 1) {
                                return const SizedBox.shrink();
                              }
                              topping = optionmenu[index - 1].option.map((e) {
                                return ToopingPick(
                                    name: e.name.toString(), price: e.price!);
                              }).toList();
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: optionmenu[index - 1].option.length,
                                itemBuilder: (context, i) {
                                  if (optionPilih!.isNotEmpty) {
                                    topping?.forEach((e) {
                                      optionPilih?.forEach((element) {
                                        if (element.name == e.name) {
                                          e.value = true;
                                        }
                                      });
                                    });
                                  }
                                  print(topping![i].value);
                                  return listTopping(topping![i]);
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
                                  child: Text(optionmenu[index].title),
                                ),
                            itemCount: 1 + optionmenu.length)
                    else
                      multipletopping(),
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
                    quantity()
                  ],
                ),
                bottomNavigationBar: bottomNavBar(),
              ),
            )));
  }

  Widget multipletopping() {
    return Wrap(
      direction: Axis.vertical,
      children: List.generate(qty, (tp) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ExpansionTile(
            tilePadding: const EdgeInsets.only(right: 40),
            childrenPadding: const EdgeInsets.only(right: 40),
            title: Text(
              "Porsi ke ${tp + 1}",
              style: normalText.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff5C5E61).withOpacity(.8)),
            ),
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0 || index == optionmenu.length + 1) {
                      return const SizedBox.shrink();
                    }
                    List<ToopingPick> topping;
                    topping = optionmenu[index - 1].option.map((e) {
                      return ToopingPick(
                          name: e.name.toString(), price: e.price!);
                    }).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: optionmenu[index - 1].option.length,
                      itemBuilder: (context, i) {
                        if (optionPilihMultiple != null) {
                          for (var e in topping) {
                            if (optionPilihMultiple!.isEmpty) {
                              print("kosong");
                            }
                            if (optionPilihMultiple!.length <= tp) {
                              print("nambah data");
                            } else {
                              optionPilihMultiple?[tp]
                                  .items
                                  ?.forEach((element) {
                                if (element.name == e.name) {
                                  e.value = true;
                                }
                              });
                            }
                          }

                          print("Data tidak kosong");
                        } else {
                          print("Data  kosong");
                        }
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return CheckboxListTile(
                            value: topping[i].value,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Row(
                              children: [
                                SizedBox(
                                    width: SizeConfig.safeBlockHorizontal * 2),
                                Text(
                                  optionmenu[index - 1]
                                      .option[i]
                                      .name
                                      .toString(),
                                  style: normalText.copyWith(fontSize: 15),
                                ),
                                const Spacer(),
                                Text(
                                  optionmenu[index - 1]
                                      .option[i]
                                      .price
                                      .toString(),
                                  style: normalText.copyWith(fontSize: 15),
                                )
                              ],
                            ),
                            onChanged: (value) {
                              if (tp > optionPilihMultiple!.length) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'mohon isi dari porsi ke 1'),
                                  ),
                                );
                              } else {
                                setState(() {
                                  topping[i].value = value!;
                                });
                                if (topping[i].value == true) {
                                  List<ToppingItem> data = [];
                                  data.add(ToppingItem(
                                      name: topping[i].name,
                                      price: topping[i].price));
                                  if (optionPilihMultiple!.isEmpty) {
                                    optionPilihMultiple
                                        ?.add(OrderTopping(items: data));
                                  } else {
                                    optionPilihMultiple!.length <= tp
                                        ? optionPilihMultiple
                                            ?.add(OrderTopping(items: data))
                                        : optionPilihMultiple![tp]
                                            .items!
                                            .addAll(data.map((e) {
                                              return ToppingItem(
                                                  name: e.name, price: e.price);
                                            }).toList());
                                  }
                                } else {
                                  optionPilihMultiple![tp].items!.removeWhere(
                                      (element) =>
                                          element ==
                                          ToppingItem(
                                              name: topping[i].name,
                                              price: topping[i].price));
                                }
                                print(optionPilihMultiple);
                              }
                            },
                          );
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                        child: Text(optionmenu[index].title),
                      ),
                  itemCount: 1 + optionmenu.length)
            ],
          ),
        );
      }),
    );
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

  Widget listTopping(ToopingPick toopingPick) {
    return Center(
      child: CheckboxListTile(
        value: toopingPick.value,
        controlAffinity: ListTileControlAffinity.leading,
        title: Row(
          children: [
            SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
            Text(
              toopingPick.name.toString(),
              style: normalText.copyWith(fontSize: 15),
            ),
            const Spacer(),
            Text(
              toopingPick.price.toString(),
              style: normalText.copyWith(fontSize: 15),
            )
          ],
        ),
        onChanged: (value) {
          setState(() {
            toopingPick.value = value!;
            if (toopingPick.value == true) {
              optionPilih?.add(
                  Option(name: toopingPick.name, price: toopingPick.price));
            } else {
              optionPilih?.removeWhere((element) =>
                  element ==
                  Option(name: toopingPick.name, price: toopingPick.price));
            }
          });

          print(optionPilih);
        },
      ),
    );
  }

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
                    if ((_toppingType == type.beda) && (qty == 1)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'quantity harus diatas 1 jika ingin tipe topping beda'),
                        ),
                      );
                    } else {
                      if (qty == 0) {
                        menuInCartBloc
                            .add(DeleteMenuInCart(widget.itemInKeranjang));
                      } else if (widget.itemInKeranjang.quantity == -1) {
                        List<OrderTopping>? multiple = [
                          OrderTopping(
                              items: optionPilih?.map((e) {
                            return ToppingItem(
                                name: e.name,
                                price: int.parse(e.price.toString()));
                          }).toList())
                        ];
                        print(multiple);
                        addMenuToCartBloc.add(AddMenuToCart(
                            option: optionPilih ?? [],
                            multiple: optionPilihMultiple!.isNotEmpty
                                ? optionPilihMultiple
                                : multiple,
                            menuModel: item,
                            quantity: qty,
                            totalPrice: (item.price ?? 0) * qty,
                            notes: _catatanController.text));
                      } else {
                        Keranjang editedMenu = widget.itemInKeranjang;
                        //deklarasi isi menu in keranjang yang akan di update
                        if (optionPilihMultiple!.isEmpty ||
                            widget.itemInKeranjang.toppings?.length == 1) {
                          setState(() {
                            optionPilihMultiple = [
                              OrderTopping(
                                  items: optionPilih?.map((e) {
                                return ToppingItem(
                                    name: e.name,
                                    price: int.parse(e.price.toString()));
                              }).toList())
                            ];
                          });
                        }
                        editedMenu.totalPrice =
                            widget.itemInKeranjang.price! * qty;
                        editedMenu.quantity = qty;
                        editedMenu.toppings = optionPilihMultiple?.map((e) {
                              return ToppingOrder(
                                  items: e.items?.map((a) {
                                return ListOption(
                                    name: a.name, price: a.price.toString());
                              }).toList());
                            }).toList() ??
                            optionPilihMultiple?.map((e) {
                              return ToppingOrder(
                                  items: optionPilih?.map((a) {
                                return ListOption(
                                    name: a.name, price: a.price.toString());
                              }).toList());
                            }).toList();
                        editedMenu.options = optionPilih?.map((e) {
                          return ListOption(
                              name: e.name, price: e.price.toString());
                        }).toList();
                        menuInCartBloc.add(UpdateMenuInCart(editedMenu));
                      }
                    }
                  }
                : null,
            child: Text('Perbarui Isi Keranjang',
                style: normalText.copyWith(fontSize: 14, color: Colors.white))),
      ),
    );
  }
}
