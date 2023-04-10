import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/Authentication/bloc/bloc/pilih_kawasan_bloc.dart';
import 'package:cafetaria/feature/Authentication/views/kawasan_sukses.dart';
import 'package:cafetaria/feature/pembeli/views/register_sukses.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterSubAdmin extends StatelessWidget {
  final User user;
  const RegisterSubAdmin({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PilihKawasanBloc(
                  categoryRepository: context.read<CategoryRepository>())
                ..add(const GetPilihKawasan()))
        ],
        child: RegisterSubAdminWidget(
          user: user,
        ));
  }
}

class RegisterSubAdminWidget extends StatefulWidget {
  final User user;
  const RegisterSubAdminWidget({Key? key, required this.user})
      : super(key: key);

  @override
  State<RegisterSubAdminWidget> createState() => _RegisterSubAdminWidgetState();
}

class _RegisterSubAdminWidgetState extends State<RegisterSubAdminWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  final TextEditingController hp = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _submitLoading = false;
  String idKawasan = "e574154f-cde0-4b49-a678-c19d1fed1bb6";
  bool _checkDisableButton() {
    if (hp.text.isEmpty) {
      return true;
    }
    if (password.text.isEmpty) {
      return true;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      nama.text = widget.user.displayName.toString();
      email.text = widget.user.email.toString();
    });
  }

  Future _onSubmit(
      context, String idKawasanPick, AuthenticationRepository auth) async {
    setState(() {
      _submitLoading = true;
    });
  
    try {
      final data = {'mobile': hp.text};
      final data2 = {
        'status': "unverified",
        'userId': widget.user.uid,
        'kawasanId': idKawasanPick
      };
      await _firebaseAuth.currentUser!.updatePassword(password.text);
      await _firestore.collection('user').doc(widget.user.uid).update(data);
      await _firestore
          .collection('kawasan')
          .doc(idKawasanPick)
          .collection("subAdminKawasan")
          .doc(widget.user.uid)
          .set(data2);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterSukses()),
      );
      Fluttertoast.showToast(
          msg: "Submit success!", toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: "$error", toastLength: Toast.LENGTH_LONG);
    } finally {
      setState(() {
        _submitLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset(Assets.images.register.path)),
            Padding(
              padding: const EdgeInsets.only(top: 36, bottom: 15),
              child: Text(
                "Daftar Sub-Admin!",
                style: extraBigText.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  ("PILIH KAWASAN").toUpperCase(),
                  style: const TextStyle(
                      fontSize: 13,
                      color: MyColors.grey1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    return Container(
                        height: 57,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                        child: DropdownButtonFormField<PilihKawasanModel>(
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.red,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Pilih di upload ',
                          ),
                          items: state.items!
                              .map((kawasan) => DropdownMenuItem(
                                    value: kawasan,
                                    child: Text(kawasan.name.toString()),
                                  ))
                              .toList(),
                          value: state.items![0],
                          onChanged: (val) {
                            context
                                .read<PilihKawasanBloc>()
                                .add(KawasanChange(val!.kawasanId.toString()));
                            setState(() {
                              idKawasan = val.kawasanId;
                            });
                          },
                        ));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextfield2(
                controller: nama,
                enable: false,
                label: "NAMA LENGKAP",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextfield2(
                controller: email,
                enable: false,
                label: "EMAIL",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextfield2(
                controller: hp,
                enable: true,
                hint: "Masukan Nomor Handphone",
                label: "NOMOR HANDPHONE",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextfield2(
                controller: password,
                enable: true,
                hint: "Masukan Password",
                label: "Password",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ReusableButton1(
                  label: "DAFTAR",
                  onPressed: () {
                    if (hp.text.isEmpty) {
                      return null;
                    }
                    if (password.text.isEmpty) {
                      return null;
                    } else {
                      _onSubmit(context, idKawasan, auth);
                    }
                  },
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  // disabled: _checkDisableButton(),
                  loading: _submitLoading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
