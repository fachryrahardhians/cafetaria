import 'package:cafetaria/feature/pembeli/views/history_detail_page.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return History();
  }
}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Color getStatusColor(int time) {
    if (time >= 15)
      return Colors.red;
    else
      return Colors.yellow;
  }

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
        body: TabBarView(
          children: [
            ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                itemBuilder: (context, index) {
                  return listCard();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: SizeConfig.safeBlockVertical * 3);
                },
                itemCount: 2),
            ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                itemBuilder: (context, index) {
                  return _doneCard();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: SizeConfig.safeBlockVertical * 3);
                },
                itemCount: 2),
          ],
        ),
      ),
    );
  }

  Widget listCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
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
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      color: getStatusColor(1).withOpacity(.25)),
                  child: Center(
                    child: Text(
                      '4 menit lalu',
                      style: textStyle.copyWith(
                          color: Color(0xffFF9500),
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    width: SizeConfig.safeBlockVertical * 9,
                    height: SizeConfig.safeBlockVertical * 9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff808285),
                              Color(0xff333435),
                              Color(0xff333435),
                            ]),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
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
                            fontSize: 11, color: Color(0xff999B9D)),
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

  Widget _doneCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HistoryDetailPage()));
      },
      child: Container(
        padding: EdgeInsets.all(16),
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
                    'Key-Pop Korean Street Food - Antapani',
                    style: headlineStyle.copyWith(fontSize: 14),
                  ),
                ),
                Text('Rp 90.000', style: textStyle),
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            Text(
              '13 Mei 2022, 20:51',
              style: textStyle.copyWith(color: Color(0xffB1B5BA)),
            )
          ],
        ),
      ),
    );
  }
}