import 'dart:async';

import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/admin/bloc/list_kawasan_bloc/list_kawasan_bloc.dart';
import 'package:cafetaria/feature/admin/bloc/update_status_bloc/update_status_bloc.dart';
import 'package:cafetaria/feature/admin/utils.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PendingSubAdmin extends StatelessWidget {
  const PendingSubAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              ListKawasanBloc(adminRepository: context.read<AdminRepository>())
                ..add(const GetListKawasan()))
    ], child: const PendingSubAdminWidget());
  }
}

class PendingSubAdminWidget extends StatefulWidget {
  const PendingSubAdminWidget({Key? key}) : super(key: key);

  @override
  State<PendingSubAdminWidget> createState() => _PendingSubAdminWidgetState();
}

class _PendingSubAdminWidgetState extends State<PendingSubAdminWidget> {
  final column = ['nama', "Email", "Kawasan", "Status"];
  List<DataColumn> columns(List<String> data) {
    return data.map((e) {
      return DataColumn(label: Text(e));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "PENDING SUB ADMIN",
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
            StreamBuilder<List<KawasanRead>>(
              stream: context.read<AdminRepository>().getStreamListKawasan(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Ada masalah ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final items = snapshot.data;
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
                            Text('$model'),
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: ((context) {
                                    return infoCart(e);
                                  }));
                            },
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
            // BlocBuilder<ListKawasanBloc, ListKawasanState>(
            //   builder: (context, state) {
            //     final status = state.status;
            //     if (status == ListKawasanStatus.loading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (status == ListKawasanStatus.failure) {
            //       return const Center(
            //         child: Text('Terjadi kesalahan'),
            //       );
            //     } else if (status == ListKawasanStatus.success) {
            //       final items = state.items!;
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
            //             columns: columns(column), rows: getRows(items)),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Dialog infoCart(KawasanRead? model) {
    bool loading = false;
    final TextEditingController nama = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController kawasan = TextEditingController();
    nama.text = model!.admin.fullname;
    email.text = model.admin.email;
    kawasan.text = model.name.toString();
    return Dialog(
        child: BlocProvider(
      create: (context) =>
          UpdateStatusBloc(adminRepository: context.read<AdminRepository>()),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Verifikasi Sub-Admin",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextfield2(
              label: "Nama Lengkap",
              enable: false,
              hint: "Masukkan nama Lengkap",
              controller: nama,
            ),
            CustomTextfield2(
              label: "EMAIL",
              enable: false,
              hint: "Masukkan nama Lengkap",
              controller: email,
            ),
            CustomTextfield2(
              label: "KAWASAN",
              enable: false,
              hint: "Masukkan nama Lengkap",
              controller: kawasan,
            ),
            BlocConsumer<UpdateStatusBloc, UpdateStatusState>(
              listener: (context, state) {
                if (state.status == FormzStatus.submissionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Status Berhasil Di Update'),
                    ),
                  );
                  setState(() {
                    loading = true;
                  });
                  Timer(
                    const Duration(seconds: 3),
                    () {
                      setState(() {
                        loading = false;
                      });
                      Navigator.of(context).pop();
                    },
                  );
                } else if (state.status == FormzStatus.submissionFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terjadi kesalahan'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffee3124)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: BorderSide.none))),
                            onPressed: () async {
                              loading == true
                                  ? loading
                                  : context.read<UpdateStatusBloc>().add(
                                      UpdateStatus(
                                          model.kawasanId, "verified"));
                            },
                            child: Text(
                              loading == true ? "LOADING" : "SETUJU",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(1)),
                            ))),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 44,
                                margin: const EdgeInsets.only(right: 8),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        side: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            side: BorderSide.none)),
                                    onPressed: () {
                                      loading == true
                                          ? loading
                                          : context
                                              .read<UpdateStatusBloc>()
                                              .add(UpdateStatus(
                                                  model.kawasanId, "block"));
                                    },
                                    child: Text(
                                      "BLOCK",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white.withOpacity(1)),
                                    )))),
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 44,
                                margin: const EdgeInsets.only(left: 8),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                          color: Colors.red,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            side: BorderSide.none)),
                                    onPressed: () {
                                      loading == true
                                          ? loading
                                          : context
                                              .read<UpdateStatusBloc>()
                                              .add(UpdateStatus(
                                                  model.kawasanId, "denied"));
                                    },
                                    child: Text(
                                      "TOLAK",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red.withOpacity(1)),
                                    ))))
                      ],
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
