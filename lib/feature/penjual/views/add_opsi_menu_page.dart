import 'dart:async';

import 'package:cafetaria/feature/penjual/bloc/opsi_menu_bloc/opsi_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/views/menu_cafetaria_page.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:formz/formz.dart';
import 'package:option_menu_repository/option_menu_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOpsiMenuPage extends StatelessWidget {
  const AddOpsiMenuPage({Key? key, required this.menuId, this.optionMenuModel})
      : super(key: key);
  final String menuId;
  final OptionMenuModel? optionMenuModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OpsiMenuBloc(
              optionMenuRepository: context.read<OptionMenuRepository>()),
        ),
      ],
      child: AddOpsiMenuView(menuid: menuId, optionMenuModel: optionMenuModel),
    );
  }
}

class AddOpsiMenuView extends StatefulWidget {
  final String? menuid;
  final OptionMenuModel? optionMenuModel;
  const AddOpsiMenuView({Key? key, this.menuid, this.optionMenuModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddOpsiMenuViewState();
}

class _AddOpsiMenuViewState extends State<AddOpsiMenuView> {
  final _textController = TextEditingController();
  String? title;
  List<Option> option = [];
  bool isMandatory = true;
  bool isMultipleTopping = false;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    if (widget.optionMenuModel != null) {
      context
          .read<OpsiMenuBloc>()
          .add(OpsiMenuChange(widget.optionMenuModel!.title.toString()));
      context
          .read<OpsiMenuBloc>()
          .add(WajibChecked(widget.optionMenuModel!.isMandatory));
      context
          .read<OpsiMenuBloc>()
          .add((BanyakPorsiChecked(widget.optionMenuModel!.isMultipleTopping)));
      for (var element in widget.optionMenuModel!.option) {
        context.read<OpsiMenuBloc>().add(OptionChange(element));
      }
      setState(() {
        title = widget.optionMenuModel!.title;
        option = widget.optionMenuModel!.option;
        isMandatory = widget.optionMenuModel!.isMandatory;
        isMultipleTopping = widget.optionMenuModel!.isMultipleTopping;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final opsi = ModalRoute.of(context)!.settings.arguments;

    // if (opsi is OpsiMenu) {
    //   _textController.text = opsi.title;
    //   option = opsi.option;
    //   isMandatory = opsi.isMandatory;
    //   isMultipleTopping = opsi.isMultipleTopping;
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.optionMenuModel != null
              ? 'EDIT OPSI MENU'
              : 'TAMBAH OPSI MENU',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.red,
        ),
        elevation: 0,
      ),
      backgroundColor: CFColors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'NAMA OPSI MENU',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  height: 47,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.0,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: widget.optionMenuModel == null ? "" : title,
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                      context.read<OpsiMenuBloc>().add(OpsiMenuChange(value));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama opsi menu',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                sectionTitle('Pilihan Opsi', 'mis: topping, ukuran, level'),
                OutlinedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TambahOpsiComponent(),
                        settings: const RouteSettings(
                          arguments: Option(name: "", price: 0),
                        ),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        context.read<OpsiMenuBloc>().add(OptionChange(result));
                        option.add(result);
                      });
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.red,
                      style: BorderStyle.solid,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: const Text(
                      'TAMBAH OPSI',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                option.isEmpty
                    ? Container()
                    : SizedBox(
                        width: double.infinity,
                        height: 40.0 * option.length,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: option.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              visualDensity: const VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.dynamic_feed_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    option[index].name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text('+ Rp${option[index].price}.00'),
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TambahOpsiComponent(),
                                      settings: RouteSettings(
                                        arguments: option[index],
                                      ),
                                    ),
                                  );
                                  if (result != null) {
                                    setState(() {
                                      option[index] = result;
                                      context
                                          .read<OpsiMenuBloc>()
                                          .add(OptionIsiChange(result, index));
                                    });
                                  }
                                },
                                child: const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                sectionTitle('Detail Opsi',
                    'mis: harus pilih setidaknya 1, tidak wajib'),
                const Text(
                  'Apakah wajib untuk memilih pilihan?',
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Ya, wajib'),
                        leading: Radio(
                          value: true,
                          groupValue: isMandatory,
                          onChanged: (val) {
                            setState(() {
                              isMandatory = true;
                              context
                                  .read<OpsiMenuBloc>()
                                  .add(WajibChecked(isMandatory));
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Tidak wajib'),
                        leading: Radio(
                          value: false,
                          groupValue: isMandatory,
                          onChanged: (val) {
                            setState(() {
                              isMandatory = false;
                              context
                                  .read<OpsiMenuBloc>()
                                  .add(BanyakPorsiChecked(isMultipleTopping));
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Berapa banyak opsi yang pelanggan bisa pilih?',
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: const Text('1 Pilihan'),
                        leading: Radio(
                          value: false,
                          groupValue: isMultipleTopping,
                          onChanged: (val) {
                            setState(() {
                              isMultipleTopping = false;
                              context
                                  .read<OpsiMenuBloc>()
                                  .add(BanyakPorsiChecked(isMultipleTopping));
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Banyak pilihan'),
                        leading: Radio(
                          value: true,
                          groupValue: isMultipleTopping,
                          onChanged: (val) {
                            setState(() {
                              isMultipleTopping = true;
                              context
                                  .read<OpsiMenuBloc>()
                                  .add(BanyakPorsiChecked(isMultipleTopping));
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<OpsiMenuBloc, OpsiMenuState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Timer(
              const Duration(seconds: 3),
              () {
                setState(() {
                  loading = false;
                });
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 250,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/icons/pop-up-success.png'),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Berhasil!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(widget.optionMenuModel != null
                                ? 'Opsi Menu baru berhasil diubah.'
                                : 'Opsi Menu baru berhasil ditambah.'),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              height: 44,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences idmercahnt =
                                      await SharedPreferences.getInstance();
                                  String id = idmercahnt
                                      .getString("merchantId")
                                      .toString();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         MenuCafetariaPage(idMerchant: id),
                                  //   ),
                                  // );
                                  // Navigator.pop(context, result);
                                },
                                child: const Text('OK'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state.status == FormzStatus.submissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Terjadi kesalahan'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: const Size.fromHeight(44),
              ),
              onPressed: () {
                //final title = _textController.text;
                if ((title != null) && option.isNotEmpty) {
                  setState(() {
                    loading = true;
                  });
                  widget.optionMenuModel == null
                      ? context
                          .read<OpsiMenuBloc>()
                          .add(SaveOpsi(widget.menuid.toString()))
                      : context.read<OpsiMenuBloc>().add(UpdateOpsi(
                          widget.optionMenuModel!.optionmenuId,
                          widget.menuid.toString()));

                  // // temp
                  // final result = OpsiMenu(
                  //   isMandatory,
                  //   isMultipleTopping,
                  //   'menuId',
                  //   option,
                  //   'optionmenuId',
                  //   title,
                  // );

                  // Navigator.pop(context, result);
                }
              },
              child: Text(
                loading
                    ? "LOADING"
                    : widget.optionMenuModel == null
                        ? 'SIMPAN'
                        : "UPDATE",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sectionTitle(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}

class TambahOpsiComponent extends StatefulWidget {
  const TambahOpsiComponent({Key? key}) : super(key: key);

  @override
  State<TambahOpsiComponent> createState() => _TambahOpsiComponentState();
}

class _TambahOpsiComponentState extends State<TambahOpsiComponent> {
  final _titleController = TextEditingController();
  final _priceController = MoneyMaskedTextController(
    precision: 0,
    thousandSeparator: ',',
    decimalSeparator: '',
  );

  @override
  Widget build(BuildContext context) {
    final option = ModalRoute.of(context)!.settings.arguments;

    if (option is Option) {
      _titleController.text = option.name.toString();
      _priceController.text = '${option.price}';
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.red),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: CFColors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tambah Opsi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'NAMA PILIHAN',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6.0),
                Container(
                  height: 47,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.0,
                    ),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama pilihan',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'HARGA JUAL',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6.0),
                Container(
                  height: 47,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Rp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan harga jual',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            final name = _titleController.text;
            final price = _priceController.numberValue.round();
            if (name.isNotEmpty && price > 0) {
              final option = Option(name: name, price: price);
              Navigator.pop(context, option);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            minimumSize: const Size.fromHeight(44),
          ),
          child: const Text(
            'TAMBAH',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
