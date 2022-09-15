import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/pembeli/bloc/merchant_byId_bloc/merchant_byId_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/merchant_byId_bloc/merchant_byId_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/rating_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:order_repository/order_repository.dart';

class HistoryDetailPage extends StatelessWidget {
  final HistoryModel item;
  final MerchantModel merchant;
  const HistoryDetailPage(
      {Key? key, required this.item, required this.merchant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MerchantByIdBloc>(
      create: (context) => MerchantByIdBloc(
          merchantRepository: context.read<MerchantRepository>())
        ..add(GetMerchantById(item.merchantId.toString())),
      child: HistoryDetail(
        item: item,
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          BlocBuilder<MerchantByIdBloc, MerchantByIdState>(
            builder: (context, state) {
              final status = state.status;
              if (status == MerchantByIdStatus.success) {
                final item = state.model!;
                return outlet(
                    'assets/images/ill_cafetaria_banner1.png',
                    true,
                    item.name.toString(),
                    '1.2 km',
                    '15 min',
                    '${item.rating} • ${item.totalCountRating} rating');
              } else if (status == MerchantByIdStatus.loading)
                return Center(child: const CircularProgressIndicator());
              else
                return SizedBox();
            },
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          Text(
            'PESANANMU',
            style: textStyle.copyWith(color: const Color(0xff8C8F93)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return menu(item.menus![index].qty!, item.menus![index].name!,
                    item.menus![index].price!);
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: SizeConfig.safeBlockVertical * 1),
              itemCount: item.menus!.length),
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
      bottomNavigationBar: Visibility(
        visible: item.ratingId==''&&item.statusOrder=='finish',
        child: ReusableButton1(
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
      ),
    );
  }

  Widget menu(int itemCount, String itemName, int totalPrice) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${itemCount}x',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 13)),
          SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemName,
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 13)),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              GestureDetector(
                onTap: () async {},
                child: Text(
                  'Edit',
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffee3124),
                      fontSize: 11),
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            'Rp. $totalPrice',
            style:
                textStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13),
          )
        ],
      ),
    );
  }
}
