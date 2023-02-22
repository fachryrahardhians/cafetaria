import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/feature/admin/bloc/list_kawasan_bloc/list_kawasan_bloc.dart';

import 'package:cafetaria/feature/admin/views/pending_sub_admin.dart';

import 'package:cafetaria/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickKawasan extends StatelessWidget {
  const PickKawasan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              ListKawasanBloc(adminRepository: context.read<AdminRepository>())
                ..add(const GetListKawasan()))
    ], child: const PickKawasanWidget());
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  const ListItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: textStyle.copyWith(fontSize: 15)),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: Color(0xffEE3124),
            ),
          ]),
        ),
        //const VerticalSeparator(height: 1),
        const Divider()
      ],
    );
  }
}

class PickKawasanWidget extends StatefulWidget {
  const PickKawasanWidget({Key? key}) : super(key: key);

  @override
  State<PickKawasanWidget> createState() => _PickKawasanWidgetState();
}

class _PickKawasanWidgetState extends State<PickKawasanWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pilih Kawasan".toUpperCase(),
          style: const TextStyle(
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: 50,
            //     child: TextField(
            //       style: const TextStyle(fontSize: 13),
            //       onSubmitted: (value) {
            //         if (value.isNotEmpty) {
            //         } else {
            //           return;
            //         }
            //       },
            //       decoration: InputDecoration(
            //         prefixIcon: const Icon(
            //           Icons.search,
            //           color: MyColors.red1,
            //           size: 20,
            //         ),
            //         hintText: "Cari Sub Admin ?",
            //         hintStyle: const TextStyle(fontSize: 13),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(100),
            //         ),
            //       ),
            //     ),
            //   ),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListItem(
                          title: items[index].name.toString(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PendingSubAdmin(
                                          idKawasan: items[index].kawasanId,
                                          kawasan: "adminKawasan",
                                        )));
                          },
                        );
                      },
                    ),
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
