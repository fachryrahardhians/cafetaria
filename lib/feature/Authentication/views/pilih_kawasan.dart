import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/Authentication/bloc/bloc/pilih_kawasan_bloc.dart';
import 'package:cafetaria/feature/Authentication/views/daftar_kawasan.dart';

import 'package:cafetaria/feature/pembeli/views/dashboard_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:category_repository/category_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:sharedpref_repository/sharedpref_repository.dart';

class PilihKwsn extends StatelessWidget {
  final bool? merchant;
  const PilihKwsn({Key? key, this.merchant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PilihKawasanBloc(
                  categoryRepository: context.read<CategoryRepository>()))
        ],
        child: PilihKawasan(
          merchant: merchant,
        ));
  }
}

class PilihKawasan extends StatefulWidget {
  final bool? merchant;
  const PilihKawasan({Key? key, this.merchant}) : super(key: key);

  @override
  State<PilihKawasan> createState() => _PilihKawasanState();
}

class _PilihKawasanState extends State<PilihKawasan> {
  String status = 'verified';

  @override
  void initState() {
    super.initState();
    context.read<AppSharedPref>().getLong().then((valueLong) {
      context.read<AppSharedPref>().getLat().then((valueLat) {
        context
            .read<PilihKawasanBloc>()
            .add(GetDistanceKawasan(long: valueLong!, lat: valueLat!));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<User?>(
              future: auth.getCurrentUser(),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Assets.images.logo.path, scale: 2),
                      Padding(
                        padding: const EdgeInsets.only(top: 36, bottom: 15),
                        child: Text(
                          "Selamat Datang Kembali di Lapaku!",
                          style: extraBigText.copyWith(
                              fontWeight: FontWeight.bold),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(kawasan.name.toString()),
                                              Text(
                                                  "${double.parse(kawasan.distance!.toStringAsFixed(2))} KM"),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                value: state.items![0],
                                onChanged: (val) {
                                  context.read<PilihKawasanBloc>().add(
                                      KawasanChange(val!.kawasanId.toString()));
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      BlocConsumer<PilihKawasanBloc, PilihKawasanState>(
                        builder: (context, state) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 100, bottom: 20),
                            child: ReusableButton1(
                              label: "Konfirmasi",
                              onPressed: () {
                                context.read<PilihKawasanBloc>().add(
                                    UpdateKawasan(
                                        snapshot.data!.uid,
                                        widget.merchant != null
                                            ? widget.merchant!
                                            : false));
                              },
                            ),
                          );
                        },
                        listener: (context, state) {
                          if (state.inputStatus ==
                              FormzStatus.submissionSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Kawasan Berhasil Di Ubah'),
                              ),
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const PembeliDashboardPage()));
                          } else if (state.inputStatus ==
                              FormzStatus.submissionFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Terjadi kesalahan'),
                              ),
                            );
                          }
                        },
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DaftarKawasan(
                                        user: snapshot.data!,
                                      )));
                        },
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
