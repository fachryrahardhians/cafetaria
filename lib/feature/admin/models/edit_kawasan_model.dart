import 'dart:async';

import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/admin/bloc/edit_kawasan_bloc/edit_kawasan_bloc.dart';
import 'package:cafetaria/feature/admin/views/edit_kawasan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

abstract class EditKawasanModel extends State<EditKawasanWidget> {
  final column = ["Kawasan Id", "Name", "status","Action"];
  List<DataColumn> columns(List<String> data) {
    return data.map((e) {
      return DataColumn(label: Text(e));
    }).toList();
  }

  Dialog infoCart(KawasanRead? model) {
    bool loading = false;
    final TextEditingController nama = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController kawasan = TextEditingController();
    nama.text = "";
    email.text = "";
    kawasan.text = model!.name.toString();
    return Dialog(
        child: BlocProvider(
      create: (context) =>
          EditKawasanBloc(adminRepository: context.read<AdminRepository>()),
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
              "Edit Sub-Admin",
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
              enable: true,
              hint: "Masukkan nama Lengkap",
              controller: kawasan,
            ),
            BlocConsumer<EditKawasanBloc, EditKawasanState>(
              listener: (context, state) {
                if (state.status == FormzStatus.submissionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
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
                                      loading == true
                                          ? loading
                                          : Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "BATAL",
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
                                          : context.read<EditKawasanBloc>().add(
                                              EditKawasanChange(model.kawasanId,
                                                  kawasan.text));
                                    },
                                    child: Text(
                                      loading == true ? "Loading " : "SIMPAN",
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

  Dialog deletecart(KawasanRead? model) {
    bool loading = false;

    return Dialog(
        child: BlocProvider(
      create: (context) =>
          EditKawasanBloc(adminRepository: context.read<AdminRepository>()),
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
              "Yakin ingin menghapus ${model!.name}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sub-Admin yang sudah dihapus tidak dapat dikembalikan.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<EditKawasanBloc, EditKawasanState>(
              listener: (context, state) {
                if (state.status == FormzStatus.submissionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
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
                                      loading == true
                                          ? loading
                                          : Navigator.of(context).pop();
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
                                      loading == true
                                          ? loading
                                          : context.read<EditKawasanBloc>().add(
                                              DeleteKawasan(model.kawasanId));
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
