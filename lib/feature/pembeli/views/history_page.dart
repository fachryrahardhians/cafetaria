import 'package:cafetaria/feature/pembeli/bloc/history_order_bloc/history_order_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/history_detail_page.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_repository/rating_repository.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const History();
  }
}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'RIWAYAT CAFETARIA',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333435)),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: MyColors.red1,
            indicatorWeight: 4,
            labelColor: textStyle.color,
            unselectedLabelColor: const Color(0xffB1B5BA),
            unselectedLabelStyle: textStyle,
            labelStyle: headlineStyle.copyWith(fontSize: 15),
            tabs: const [
              Tab(
                text: 'Proses',
                iconMargin: EdgeInsets.only(bottom: 4),
              ),
              Tab(
                text: 'Selesai',
                iconMargin: EdgeInsets.only(bottom: 4),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [SizedBox(), DoneList()],
        ),
      ),
    );
  }
}

class ProcessList extends StatelessWidget {
  const ProcessList({Key? key}) : super(key: key);

  Color getStatusColor(int time) {
    if (time >= 15) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HistoryOrderBloc(ratingRepository: context.read<RatingRepository>())
            ..add(const GetHistoryOrder('process')),
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          itemBuilder: (context, index) {
            return listCard(context);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: SizeConfig.safeBlockVertical * 3);
          },
          itemCount: 2),
    );
  }

  Widget listCard(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(.04),
                  blurRadius: 12)
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: SizeConfig.safeBlockHorizontal * 30,
                  height: SizeConfig.safeBlockVertical * 3,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      color: getStatusColor(1).withOpacity(.25)),
                  child: Center(
                    child: Text(
                      '4 menit lalu',
                      style: textStyle.copyWith(
                          color: const Color(0xffFF9500),
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    width: SizeConfig.safeBlockVertical * 9,
                    height: SizeConfig.safeBlockVertical * 9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff808285),
                              Color(0xff333435),
                              Color(0xff333435),
                            ]),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 12)
                        ]),
                    child: Column(
                      children: [
                        Text(
                          'Rab',
                          style: textStyle.copyWith(color: Colors.white),
                        ),
                        Text('13',
                            style: headlineStyle.copyWith(
                              color: Colors.white,
                            )),
                        Text(
                          'JUN',
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(.5)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 55,
                        child: Text(
                          'Cafetaria #1234567890',
                          style: headlineStyle.copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * 1),
                      Text(
                        'Apartemen Skyline Residence',
                        style: textStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * .5),
                      Text(
                        'Tower A • Lantai 1 • Nomor 37',
                        style: textStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * .5),
                      Text(
                        'Perkiraan waktu 08:00 - 10:00',
                        style: textStyle.copyWith(
                            fontSize: 11, color: const Color(0xff999B9D)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoneList extends StatefulWidget {
  const DoneList({Key? key}) : super(key: key);

  @override
  State<DoneList> createState() => _DoneListState();
}

class _DoneListState extends State<DoneList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HistoryOrderBloc(ratingRepository: context.read<RatingRepository>())
            ..add(const GetHistoryOrder('done')),
      child: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (context, state) {
          final status = state.status;
          if (status == HistoryOrderStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (status == HistoryOrderStatus.failure) {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          } else if (status == HistoryOrderStatus.success) {
            if (state.items != null) {
              final items = state.items!;
              return SizedBox(
                height: 200,
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _doneCard(
                          merchant: item.merchantId ?? '',
                          price: item.total.toString(),
                          date: item.timestamp ?? '');
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: SizeConfig.safeBlockVertical * 3);
                    },
                    itemCount: 1),
              );
            } else {
              return const Text('No Data');
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _doneCard(
      {required String merchant, required String date, required String price}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const HistoryDetailPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: boxShadows),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 50,
                  child: Text(
                    merchant,
                    style: headlineStyle.copyWith(fontSize: 14),
                  ),
                ),
                Text('Rp$price', style: textStyle),
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            Text(
              date,
              style: textStyle.copyWith(color: const Color(0xffB1B5BA)),
            )
          ],
        ),
      ),
    );
  }
}
