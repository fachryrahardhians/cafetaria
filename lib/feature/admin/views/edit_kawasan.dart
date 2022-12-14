import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/feature/admin/bloc/list_kawasan_bloc/list_kawasan_bloc.dart';
import 'package:cafetaria/feature/admin/models/edit_kawasan_model.dart';
import 'package:cafetaria/feature/admin/utils.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditKawasan extends StatelessWidget {
  const EditKawasan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              ListKawasanBloc(adminRepository: context.read<AdminRepository>())
                ..add(const GetListKawasan()))
    ], child: const EditKawasanWidget());
  }
}

class EditKawasanWidget extends StatefulWidget {
  const EditKawasanWidget({Key? key}) : super(key: key);

  @override
  State<EditKawasanWidget> createState() => _EditKawasanWidgetState();
}

class _EditKawasanWidgetState extends EditKawasanModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "ATUR SUB-ADMIN",
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
                    hintText: "Cari Sub Admin ?",
                    hintStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
            // StreamBuilder<List<KawasanRead>>(
            //   stream: context.read<AdminRepository>().getStreamListKawasan(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Text("Ada masalah ${snapshot.error}");
            //     } else if (snapshot.hasData) {
            //       final items = snapshot.data;
            //       List<DataRow> getRows(List<KawasanRead> data) =>
            //           data.map((e) {
            //             final cell = [
            //               e.admin.fullname,
            //               e.admin.email,
            //               e.name,
            //               e.status
            //             ];
            //             return DataRow(
            //                 cells: Utils.modelBuilder(cell, (index, model) {
            //               return DataCell(
            //                 Text('$model'),
            //                 onTap: () {
            //                   showDialog(
            //                       barrierDismissible: false,
            //                       context: context,
            //                       builder: ((context) {
            //                         return infoCart(e);
            //                       }));
            //                 },
            //               );
            //             }));
            //           }).toList();

            //       return SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: DataTable(
            //             columns: columns(column), rows: getRows(items!)),
            //       );
            //     } else {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
            BlocBuilder<ListKawasanBloc, ListKawasanState>(
              builder: (context, state) {
                final status = state.status;
                if (status == ListKawasanStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status == ListKawasanStatus.failure) {
                  return const Center(
                    child: Text('Terjadi kesalahan'),
                  );
                } else if (status == ListKawasanStatus.success) {
                  final items = state.items!;
                  List<DataRow> getRows(List<KawasanRead> data) =>
                      data.map((e) {
                        final cell = [
                          e.admin.fullname,
                          e.admin.email,
                          e.name,
                          e.status
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
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: ((context) {
                                                        return infoCart(e);
                                                      }));
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
                        columns: columns(column), rows: getRows(items)),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
