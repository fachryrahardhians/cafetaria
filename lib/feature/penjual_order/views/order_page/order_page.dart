// import 'package:cafetaria/components/tiles/custom_tiles.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_order_bloc/penjual_order_bloc.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_order_bloc/penjual_order_event.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_order_bloc/penjual_order_state.dart';
import 'package:cafetaria/feature/penjual_order/views/order_page/detail_order_page.dart';
// import 'package:cafetaria/feature/penjual/views/order_page/detail_order_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PenjualOrderBloc>(
      create: (context) => PenjualOrderBloc(
          context.read<PenjualOrderRepository>(), context.read<AppSharedPref>())
        ..add(
          GetPenjualOrder(),
        ),
      child: const OrderPageView(),
    );
  }
}

class OrderPageView extends StatefulWidget {
  const OrderPageView({Key? key}) : super(key: key);

  @override
  State<OrderPageView> createState() => _OrderPageViewState();
}

class _OrderPageViewState extends State<OrderPageView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  // final RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

  reloadOrder(BuildContext context) {
    context.read<PenjualOrderBloc>().add(GetPenjualOrder());
    // _refreshController.loadComplete();
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
              BlocBuilder<PenjualOrderBloc, PenjualOrderState>(
                builder: (context, state) {
                  if (state is PenjualOrderSuccess) {
                    return TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      labelColor: MyColors.red1,
                      tabs: const <Widget>[
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
                    );
                  }

                  return TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelColor: MyColors.red1,
                    tabs: const <Widget>[
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<PenjualOrderBloc, PenjualOrderState>(
        builder: (BuildContext context, state) {
          if (state is PenjualOrderLoading) {
            return TabBarView(
              controller: _tabController,
              children: List.generate(
                  _tabController.length,
                  (index) => const Center(
                        child: CircularProgressIndicator(),
                      )),
            );
          }

          if (state is PenjualOrderSuccess) {
            return TabBarView(
              controller: _tabController,
              children: [
                OrderTabContent(list: state.listBaru),
                OrderTabContent(list: state.listBooking),
                OrderTabContent(list: state.diterima),
                OrderTabContent(list: state.ditolak),
                OrderTabContent(list: state.list),
              ],
            );
          }

          if (state is PenjualOrderError) {
            return TabBarView(
              controller: _tabController,
              children: List.generate(
                _tabController.length,
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
            controller: _tabController,
            children: List.generate(
              _tabController.length,
              (index) => Center(
                child: Text(
                  "Loading",
                  style: normalText,
                ),
              ),
            ),
          );
        },
      ),
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DetailOrderPage(
                      order: list[index],
                    ),
                  ),
                ).then((value) {
                  context.read<PenjualOrderBloc>().add(
                        GetPenjualOrder(),
                      );
                });
              },
              child: OrderCard(
                order: list[index],
              )),
          itemCount: list.length,
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

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.order}) : super(key: key);

  final PenjualOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            padding:
                const EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    offset: Offset(0, 0),
                    spreadRadius: 3,
                    blurRadius: 3,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    CustomTileDateBox(
                      timestamp: order.pickupDate!,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order #${order.docId}",
                          style: bigText.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Apartemen Skyline Residence",
                          style: bigText,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Tower A • Lantai 3A • Nomor 37",
                          style: normalText,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: "Keterangan : ",
                        style: smallText.copyWith(color: MyColors.red1)),
                    TextSpan(
                        text: order.keterangan ?? '',
                        style: smallText.copyWith(color: MyColors.grey2))
                  ]),
                ),
              ],
            ),
          ),
          const Positioned(
            right: 0,
            top: 0,
            child: CustomTileTimeBadge(),
          )
        ],
      ),
    );
  }
}

class CustomTileDateBox extends StatelessWidget {
  const CustomTileDateBox({Key? key, required this.timestamp})
      : super(key: key);

  final Timestamp timestamp;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff808285),
              Color(0xff808285),
              Color(0xff333435),
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            DateFormat('EEE').format(timestamp.toDate()),
            style: normalText.copyWith(color: Colors.white),
          ),
          Text(
            "${timestamp.toDate().day}",
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            DateFormat('MMM').format(timestamp.toDate()),
            style: normalText.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CustomTileTimeBadge extends StatelessWidget {
  const CustomTileTimeBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
        color: MyColors.green1.withOpacity(0.3),
      ),
      child: Text(
        "3 Menit lalu",
        style: normalText.copyWith(
            color: MyColors.green1, fontWeight: FontWeight.bold),
      ),
    );
  }
}
