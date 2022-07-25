import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/model/menu_model_obs.dart';
import 'package:cafetaria/feature/penjual/views/booking/booking_settings.dart';
import 'package:cafetaria/feature/penjual/views/booking/controller/booking_controller.dart';
import 'package:cafetaria/feature/penjual/views/booking/widgets/item_menu.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:get/get.dart';

class AturBookingPage extends StatelessWidget {
  AturBookingPage({Key? key}) : super(key: key);

  final bookC = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MenuMakananBloc(
            categoryRepository: context.read<CategoryRepository>(),
          )..add(GetMenuMakanan(bookC.merchantId)),
        ),
        BlocProvider(
          create: (context) => ListMenuBloc(
            menuRepository: context.read<MenuRepository>(),
          ),
        ),
      ],
      child: AturBookingView(bookC.merchantId),
    );
  }
}

class AturBookingView extends StatelessWidget {
  const AturBookingView(this.merchantId, {Key? key}) : super(key: key);

  final String merchantId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATUR BOOKING'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: MyColors.red1,
                        ),
                        hintText: "Cari diskon",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: MyColors.grey3,
                        backgroundImage: AssetImage("assets/icons/info.png"),
                      ),
                      SizedBox(width: 5),
                      Text("Pilih menu yang ingin diatur booking"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListMenuWidget(merchantId),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookingSettingsPage(),
                    ),
                  );
                },
                child: const Text("PILIH MENU"),
                style: ElevatedButton.styleFrom(
                  primary: MyColors.disabledRed1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListMenuWidget extends StatelessWidget {
  const ListMenuWidget(this.merchantId, {Key? key}) : super(key: key);
  final String merchantId;
  @override
  Widget build(BuildContext context) {
    final status = context.watch<MenuMakananBloc>().state.status;

    if (status == MenuMakananStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (status == MenuMakananStatus.failure) {
      return const Center(
        child: Text('Terjadi kesalahan'),
      );
    } else if (status == MenuMakananStatus.success) {
      // final cat = categoryState.items.first;
      final cat = context.watch<MenuMakananBloc>().state.items!.first;
      context.read<ListMenuBloc>().add(GetListMenu(merchantId, cat.categoryId!));
      return BlocBuilder<ListMenuBloc, ListMenuState>(
        builder: (context, state) {
          final status = state.status;

          if (status == ListMenuStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == ListMenuStatus.failure) {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          } else if (status == ListMenuStatus.success) {
            final items = state.items!;

            List<String> allCategory = [];

            for (var menu in items) {
              if (allCategory.contains(menu.categoryId)) {
                continue;
              } else {
                allCategory.add(menu.categoryId!);
              }
            }

            List<List<MenuModel>> allMenu = [];

            for (var category in allCategory) {
              List<MenuModel> allMenuByCategory = [];
              for (var menu in items) {
                if (menu.categoryId == category) {
                  allMenuByCategory.add(menu);
                }
              }
              allMenu.add(allMenuByCategory);
            }

            return ListView.builder(
              itemCount: allMenu.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, indexAllMenu) {
                List<MenuModel> menuByCategory = allMenu[indexAllMenu];
                String categoryId = allCategory[indexAllMenu];
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuByCategory.length,
                  itemBuilder: (context, index) {
                    MenuModel menu = menuByCategory[index];
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            categoryId,
                            style: const TextStyle(
                              color: MyColors.grey3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ItemMenu(menu: MenuModelObs()),
                          // ItemMenu(menu: menu),
                        ],
                      );
                    }
                    // return ItemMenu(menu:  menu);
                    return ItemMenu(menu: MenuModelObs());
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      );
    }

    return const SizedBox.shrink();
  }
}
