import 'package:cafetaria/components/tiles/custom_tiles.dart';
import 'package:cafetaria/feature/penjual/views/order_page/detail_order_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderPageView();
  }
}

class OrderPageView extends StatefulWidget {
  OrderPageView({Key? key}) : super(key: key);

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
          preferredSize: Size.fromHeight(90),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 24, right: 24),
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
              TabBar(
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
                    icon: OrderTabTitle(title: "Status"),
                  ),
                ],
              ),
            ],
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
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderTabContent(),
          OrderTabContent(),
          OrderTabContent(),
          OrderTabContent(),
          OrderTabContent(),
        ],
      ),
    );
  }
}

class OrderTabContent extends StatelessWidget {
  const OrderTabContent({
    Key? key,
  }) : super(key: key);

  // final List<OrderModel> items;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DetailOrderPage(),
                  ),
                );
              },
              child: OrderCard()),
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
