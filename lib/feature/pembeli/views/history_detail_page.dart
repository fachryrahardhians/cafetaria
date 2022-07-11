import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/pembeli/views/rating_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:order_repository/order_repository.dart';

class HistoryDetailPage extends StatelessWidget {
  final HistoryModel item;
  const HistoryDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HistoryDetail(
      item: item,
    );
  }
}

class HistoryDetail extends StatefulWidget {
  final HistoryModel item;
  const HistoryDetail({Key? key, required this.item}) : super(key: key);

  @override
  State<HistoryDetail> createState() => _HistoryDetailState(item);
}

class _HistoryDetailState extends State<HistoryDetail> {
  HistoryModel item;
  _HistoryDetailState(this.item);
  double subTotal = 0.0;
  double ppn = 0.0;

  @override
  void initState() {
    subTotal = ((item.total! - 2000) / 1.1);
    ppn = subTotal * .1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'DETAIL RIWAYAT',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff333435)),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          outlet(
              'assets/images/ill_cafetaria_banner1.png',
              true,
              'Key-Pop Korean Street Food - Antapani',
              '1.2 km',
              '15 min',
              '4.8 • 1rb+ rating'),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          Text(
            'PESANANMU',
            style: textStyle.copyWith(color: const Color(0xff8C8F93)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: textStyle,
              ),
              Text(
                'Rp ' + subTotal.toStringAsFixed(0),
                style: textStyle.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PPN 10%',
                style: textStyle,
              ),
              Text(
                'Rp ' + ppn.toStringAsFixed(0),
                style: textStyle.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          Row(
            children: [
              Text(
                'Biaya Pemesanan ',
                style: textStyle,
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.info,
                  color: Color(0xffee3124),
                  size: 18,
                ),
              ),
              const Spacer(),
              Text(
                'Rp 2000',
                style: textStyle.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL PEMBAYARAN',
                style: textStyle.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                'Rp ' + item.total.toString(),
                style: textStyle.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 15),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: ReusableButton1(
        label: 'BELI NILAI DAN ULASAN',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RatingPage(
                        orderId: item.orderId ?? '',
                        merchantId: item.merchantId ?? '',
                      )));
        },
      ),
    );
  }
}
