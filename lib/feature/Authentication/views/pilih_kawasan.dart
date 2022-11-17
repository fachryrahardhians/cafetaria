import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/Authentication/bloc/bloc/pilih_kawasan_bloc.dart';
import 'package:cafetaria/feature/Authentication/views/daftar_kawasan.dart';

import 'package:cafetaria/feature/Authentication/views/login_page.dart';
import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PilihKwsn extends StatelessWidget {
  const PilihKwsn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => PilihKawasanBloc(
              categoryRepository: context.read<CategoryRepository>())
            ..add(const GetPilihKawasan()))
    ], child: const PilihKawasan());
  }
}

class PilihKawasan extends StatefulWidget {
  const PilihKawasan({Key? key}) : super(key: key);

  @override
  State<PilihKawasan> createState() => _PilihKawasanState();
}

class _PilihKawasanState extends State<PilihKawasan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BoxLogo(),
                Padding(
                  padding: const EdgeInsets.only(top: 36, bottom: 15),
                  child: Text(
                    "Selamat Datang Kembali di Komplekku!",
                    style: extraBigText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Cari dan Temukan Kawasanmu!",
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.all(58.0),
                  child: BlocBuilder<PilihKawasanBloc, PilihKawasanState>(
                    builder: (context, state) {
                      final status = state.status;
                      if (status == PilihKawasanStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (status == PilihKawasanStatus.failure) {
                        return const Center(
                          child: Text('Terjadi kesalahan'),
                        );
                      } else if (status == PilihKawasanStatus.success) {
                        // final items = state.items!;
                        return DropdownButtonFormField<PilihKawasanModel>(
                          items: state.items!
                              .map((kawasan) => DropdownMenuItem(
                                    value: kawasan,
                                    child: Text(kawasan.namaKawasan.toString()),
                                  ))
                              .toList(),
                          value: state.items![0],
                          onChanged: (val) {
                            context
                                .read<PilihKawasanBloc>()
                                .add(KawasanChange(val!.adminId.toString()));
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 20),
                  child: ReusableButton1(
                    label: "Konfirmasi",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PembeliDashboardPage()));
                    },
                  ),
                ),
                InkWell(
                  child: Text(
                    "Daftarkan Kawasan",
                    style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DaftarKawasan()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
