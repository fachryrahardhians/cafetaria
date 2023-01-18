import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/admin/bloc/list_kawasan_bloc/list_kawasan_bloc.dart';
import 'package:cafetaria/feature/admin/models/edit_kawasan_model.dart';
import 'package:cafetaria/feature/admin/models/home_info_model.dart';
import 'package:cafetaria/feature/admin/utils.dart';
import 'package:cafetaria/feature/admin/views/tambah_info.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeInfoWidget();
  }
}

class HomeInfoWidget extends StatefulWidget {
  const HomeInfoWidget({Key? key}) : super(key: key);

  @override
  State<HomeInfoWidget> createState() => _HomeInfoWidgetState();
}

class _HomeInfoWidgetState extends HomeInfoModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "ATUR INFO",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff333435)),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextField(
                  style: const TextStyle(fontSize: 13),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                    } else {
                      return;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: MyColors.red1,
                      size: 20,
                    ),
                    hintText: "Cari Info ?",
                    hintStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder<List<InfoModel>>(
              stream: context.read<AdminRepository>().getStreamInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Ada masalah ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final items = snapshot.data;
                  List<DataRow> getRows(List<InfoModel> data) => data.map((e) {
                        final cell = [
                          e.title,
                          "${convertDateTime(DateTime.parse(e.publishDate!))} s/d ${convertDateTime(DateTime.parse(e.expDate!))}",
                          e.status,
                          e.body,
                        ];
                        return DataRow(
                            cells: Utils.modelBuilder(cell, (index, model) {
                          return DataCell(
                            index == 3
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    7,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty.all(
                                                            0),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            const Color(
                                                                0xffee3124)),
                                                    shape: MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(6),
                                                            side: BorderSide.none))),
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              TambahInfo(
                                                                infoModel: e,
                                                              )));
                                                },
                                                child: const Center(child: Icon(Icons.edit)))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    7,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty.all(
                                                            0),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            const Color(
                                                                0xffee3124)),
                                                    shape: MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(6),
                                                            side: BorderSide.none))),
                                                onPressed: () async {
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: ((context) {
                                                        return deletecart(e);
                                                      }));
                                                },
                                                child: const Center(child: Icon(Icons.delete)))),
                                      ),
                                    ],
                                  )
                                : Text('$model'),
                            // onTap: () {
                            //   showDialog(
                            //       context: context,
                            //       builder: ((context) {
                            //         return infoCart(e);
                            //       }));
                            // },
                          );
                        }));
                      }).toList();

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: columns(column), rows: getRows(items!)),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ReusableButton1(
            label: "TAMBAH INFO",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TambahInfo()));
            },
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
