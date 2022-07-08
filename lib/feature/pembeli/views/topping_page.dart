import 'package:cafetaria/feature/pembeli/data/model/makanan_model.dart';
import 'package:cafetaria/feature/pembeli/data/model/order_model.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';

enum type { Sama, Beda }

class SelectToppingPage extends StatelessWidget {
  final String photo;
  const SelectToppingPage({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectTopping(photo: photo);
  }
}

class SelectTopping extends StatefulWidget {
  final String photo;
  const SelectTopping({Key? key, required this.photo}) : super(key: key);

  @override
  State<SelectTopping> createState() => _SelectToppingState(photo);
}

class _SelectToppingState extends State<SelectTopping> {
  type? _toppingType = type.Sama;
  String photo;
  _SelectToppingState(this.photo);
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _counterController =
      TextEditingController(text: '0');
  int qty = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFCFBFC),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'itemName',
            style: TextStyle(
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            _menuInfo(),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            Text(
              'Topping',
              style: normalText.copyWith(fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<type>(
                        value: type.Sama,
                        groupValue: _toppingType!,
                        onChanged: (type? value) {
                          setState(() {
                            _toppingType = value;
                          });
                        },
                      ),
                      SizedBox(width: 3),
                      Text('Topping Sama')
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<type>(
                        value: type.Beda,
                        groupValue: _toppingType!,
                        onChanged: (type? value) {
                          setState(() {
                            _toppingType = value;
                          });
                        },
                      ),
                      SizedBox(width: 3),
                      Text('Topping Beda')
                    ],
                  ),
                )
              ],
            ),
            Text(
              'Topping',
              style: normalText.copyWith(fontSize: 14),
            ),
            listTopping(),
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
    );
  }

  Widget _menuInfo() {
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
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(photo), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tteokbokki Polos Reguler'),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                const Text('Rp 0'),
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 70,
                  child: const Text(
                      'Nasinya gurih karena dibumbui serai, santan, dan daun kemangi. Sementara ayamnya diolesi margarin dan kecap manis. Mantap!'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget topping() {
    return Row(
      children: [
        Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            value: false,
            onChanged: (newValue) {
              if (newValue!) {
              } else {}
            }),
        SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
        Text(
          'topping name',
          style: normalText.copyWith(fontSize: 15),
        ),
        const Spacer(),
        Text(
          '+ Rp. 0',
          style: normalText.copyWith(fontSize: 15),
        )
      ],
    );
  }

  Widget listTopping() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return topping();
        },
        separatorBuilder: (context, index) =>
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
        itemCount: 3);
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
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xffee3124)),
                foregroundColor:
                    MaterialStateProperty.all(const Color(0xffee3124)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none))),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Perbarui Isi Keranjang',
                style: normalText.copyWith(fontSize: 14, color: Colors.white))),
      ),
    );
  }
}

class ToppingPage extends StatefulWidget {
  final String photo;
  final Menu foodItem;
  final int qty;
  final String note;

  const ToppingPage(
      {Key? key,
      required this.photo,
      required this.foodItem,
      required this.qty,
      required this.note})
      : super(key: key);

  @override
  State<ToppingPage> createState() =>
      _ToppingPageState(photo, foodItem, qty, note);
}

class _ToppingPageState extends State<ToppingPage> {
  String photo;
  Menu foodItem;
  int qty;
  String note;
  _ToppingPageState(this.photo, this.foodItem, this.qty, this.note);

  int totalToppingPrice = 0;
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _counterController =
      TextEditingController(text: '0');
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff333435));
  TextStyle headlineStyle = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 24, color: Color(0xff333435));
  List<_ListTopping> lists = [];
  @override
  void initState() {
    super.initState();
    lists = foodItem.toppings
        .map((e) => _ListTopping(name: e.name, price: e.price))
        .toList();
    _counterController.text = qty.toString();
    _catatanController.text = note;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFCFBFC),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            foodItem.itemName,
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            Hero(
              tag: foodItem.itemId,
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.safeBlockVertical * 20,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(photo), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  foodItem.itemName,
                  style: textStyle.copyWith(fontSize: 16),
                ),
                Column(
                  children: [
                    Text(
                      'Rp. ' + foodItem.price.toString(),
                      style: headlineStyle.copyWith(fontSize: 16),
                    ),
                    foodItem.isActivePromo
                        ? Text(
                            'Rp. ' +
                                (foodItem.price / (1 - foodItem.percentPromo))
                                    .toStringAsFixed(0),
                            style: textStyle.copyWith(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: const Color(0xffB2B4B5),
                                fontSize: 11,
                                color: const Color(0xffB2B4B5)),
                          )
                        : const SizedBox()
                  ],
                ),
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            foodItem.toppings.isEmpty
                ? const SizedBox()
                : Text(
                    'Topping',
                    style: headlineStyle.copyWith(fontSize: 14),
                  ),
            listTopping(),
            Text(
              'CATATAN UNTUK PENJUAL',
              style: headlineStyle.copyWith(
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
    );
  }

  Widget topping(_ListTopping topping) {
    return Row(
      children: [
        Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            value: topping.value,
            onChanged: (newValue) {
              if (newValue!) {
                setState(() {
                  topping.value = newValue;
                  totalToppingPrice += topping.price;
                });
              } else {
                setState(() {
                  topping.value = newValue;
                  totalToppingPrice -= topping.price;
                });
              }
            }),
        SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
        Text(
          topping.name,
          style: textStyle.copyWith(fontSize: 15),
        ),
        const Spacer(),
        Text(
          '+ Rp. ' + topping.price.toString(),
          style: textStyle.copyWith(fontSize: 15),
        )
      ],
    );
  }

  Widget listTopping() {
    if (foodItem.toppings.isEmpty) {
      return const SizedBox();
    } else {
      return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return topping(lists[index]);
          },
          separatorBuilder: (context, index) =>
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
          itemCount: foodItem.toppings.length);
    }
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
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xffee3124)),
                foregroundColor:
                    MaterialStateProperty.all(const Color(0xffee3124)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none))),
            onPressed: () {
              List<dynamic> topping = [];
              for (var element in lists) {
                if (element.value) {
                  topping
                      .add(Toppings(name: element.name, price: element.price));
                }
              }
              FoodOrder order = FoodOrder(
                  item: Item(
                    itemId: foodItem.itemId,
                    price: foodItem.price,
                    itemName: foodItem.itemName,
                    toppings: topping,
                  ),
                  note: _catatanController.text,
                  qty: qty,
                  merchantId: foodItem.merchantId,
                  totalPrice: (foodItem.price + totalToppingPrice) * qty);
              Navigator.pop(context, order);
            },
            child: Text(
                qty == 0
                    ? 'Perbarui Isi Keranjang'
                    : 'Perbarui Isi Keranjang - Rp. ' +
                        ((foodItem.price + totalToppingPrice) * qty).toString(),
                style:
                    headlineStyle.copyWith(fontSize: 14, color: Colors.white))),
      ),
    );
  }
}

class _ListTopping {
  _ListTopping({required this.name, required this.price});
  final String name;
  final int price;
  bool value = false;
}
