import 'dart:async';

import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/admin/bloc/add_info_bloc/add_info_bloc.dart';
import 'package:cafetaria/feature/admin/bloc/edit_kawasan_bloc/edit_kawasan_bloc.dart';

import 'package:cafetaria/feature/admin/views/home_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

abstract class HomeInfoModel extends State<HomeInfoWidget> {
  final column = ['Judul', "Tanggal", "Status", "Action"];
  List<DataColumn> columns(List<String> data) {
    return data.map((e) {
      return DataColumn(label: Text(e));
    }).toList();
  }

  String convertDateTime(DateTime? dateTime) {
    String month;

    switch (dateTime?.month) {
      case 1:
        month = 'Januari';
        break;
      case 2:
        month = 'Febuari';
        break;
      case 3:
        month = 'Maret';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'Mei';
        break;
      case 6:
        month = 'Juni';
        break;
      case 7:
        month = 'Juli';
        break;
      case 8:
        month = 'Agustus';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Oktober';
        break;
      case 11:
        month = 'November';
        break;
      default:
        month = 'Desember';
    }

    return '${dateTime?.day} $month ${dateTime?.year}';
  }

  Dialog deletecart(InfoModel? model) {
    bool loading = false;

    return Dialog(
        child: BlocProvider(
      create: (context) =>
          AddInfoBloc(adminRepository: context.read<AdminRepository>()),
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
            Text(
              "Yakin ingin menghapus ${model!.title}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Info yang sudah dihapus tidak dapat dikembalikan.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AddInfoBloc, AddInfoState>(
              listener: (context, state) {
                if (state.status == FormzStatus.submissionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("info berhasil di hapus"),
                    ),
                  );
                  Navigator.of(context).pop();
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
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: 44,
                                margin: const EdgeInsets.only(right: 8),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xffee3124)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                side: BorderSide.none))),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "TIDAK",
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
                                      context
                                          .read<AddInfoBloc>()
                                          .add(DeleteInfo(model));
                                    },
                                    child: Text(
                                      loading == true ? "Loading " : "Iya",
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
