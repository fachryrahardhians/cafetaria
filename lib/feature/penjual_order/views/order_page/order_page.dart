import 'package:cafetaria/components/tiles/custom_tiles.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_order_bloc/penjual_order_bloc.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_order_bloc/penjual_order_event.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_order_bloc/penjual_order_state.dart';
import 'package:cafetaria/feature/penjual_order/views/order_page/detail_order_page.dart';
// import 'package:cafetaria/feature/penjual/views/order_page/detail_order_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider<PenjualOrderBloc>(
        create: (context) => PenjualOrderBloc(
          context.read<PenjualOrderRepository>(),
        )..add(
            GetPenjualOrder(),
          ),
        child: const OrderPageView(),
      ),
    );
  }
}

class OrderPageView extends StatefulWidget {
  const OrderPageView({Key? key}) : super(key: key);

  @override
  State<OrderPageView> createState() => _OrderPageViewState();
}

class _OrderPageViewState extends State<OrderPageView> {
  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: MyColors.red1,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: DefaultTabController(
            length: 5,
            initialIndex: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 24, right: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pesanan",
                        style: extraBigText.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const Icon(
                        Icons.search,
                        color: MyColors.red1,
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  isScrollable: true,
                  // controller: _tabController,
                  labelColor: MyColors.red1,
                  tabs: <Widget>[
                    Tab(
                      icon: OrderTabTitle(title: "Baru Datang"),
                    ),
                    Tab(
                      icon: OrderTabTitle(title: "Booking"),
                    ),
                    Tab(
                      icon: OrderTabTitle(title: "Diterima"),
                    ),
                    Tab(
                      icon: OrderTabTitle(title: "Ditolak"),
                    ),
                    Tab(
                      icon: OrderTabTitle(title: "Semua"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // bottom: TabBar(
        //   isScrollable: true,
        //   controller: _tabController,
        //   labelColor: MyColors.red1,
        //   tabs: const <Widget>[
        //     Tab(
        //       icon: OrderTabTitle(title: "Baru Datang"),
        //     ),
        //     Tab(
        //       icon: OrderTabTitle(title: "Booking"),
        //     ),
        //     Tab(
        //       icon: OrderTabTitle(title: "Diterima"),
        //     ),
        //     Tab(
        //       icon: OrderTabTitle(title: "Ditolak"),
        //     ),
        //     Tab(
        //       icon: OrderTabTitle(title: "Status"),
        //     ),
        //   ],
        // ),
      ),
      body: BlocBuilder<PenjualOrderBloc, PenjualOrderState>(
        builder: (BuildContext context, state) {
          try {
            if (state is PenjualOrderLoading) {
              return TabBarView(
                // controller: _tabController,
                children: List.generate(
                    5,
                    (index) => const Center(
                          child: CircularProgressIndicator(),
                        )),
              );
            }

            if (state is PenjualOrderSuccess) {
              return TabBarView(
                // controller: _tabController,
                children: [
                  OrderTabContent(list: state.list),
                  OrderTabContent(list: state.list),
                  OrderTabContent(list: state.list),
                  OrderTabContent(list: state.list),
                  OrderTabContent(list: state.list),
                ],
              );
            }

            if (state is PenjualOrderError) {
              return TabBarView(
                // controller: _tabController,
                children: List.generate(
                  // _tabController.length,
                  5,
                  (index) => Center(
                    child: Text(
                      "Something Wrong",
                      style: normalText,
                    ),
                  ),
                ),
              );
            }

            return TabBarView(
              // controller: _tabController,
              children: List.generate(
                // _tabController.length,
                5,
                (index) => Center(
                  child: Text(
                    "Loading",
                    style: normalText,
                  ),
                ),
              ),
            );
          } catch (e) {
            return TabBarView(
              // controller: _tabController,
              children: List.generate(
                // _tabController.length,
                5,
                (index) => Center(
                  child: Text(
                    "$e",
                    style: normalText,
                  ),
                ),
              ),
            );
          }
        },
      ),
      // body: TabBarView(
      //   controller: _tabController,
      //   children: [
      //     OrderTabContent(),
      //     OrderTabContent(),
      //     OrderTabContent(),
      //     OrderTabContent(),
      //     OrderTabContent(),
      //   ],
      // ),
    );
  }
}

class OrderTabContent extends StatelessWidget {
  const OrderTabContent({
    Key? key,
    required this.list,
  }) : super(key: key);

  // final List<OrderModel> items;
  final List<PenjualOrderModel> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const DetailOrderPage(),
                  ),
                );
              },
              child: const OrderCard()),
          itemCount: 5,
        ),
      ),
    );
  }
}

class OrderTabTitle extends StatelessWidget {
  const OrderTabTitle({Key? key, required this.title, this.color})
      : super(key: key);

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87),
      ),
    );
  }
}
