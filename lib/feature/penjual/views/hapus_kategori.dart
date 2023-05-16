import 'package:cafetaria/feature/penjual/bloc/list_category/list_category.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HapusKategori extends StatelessWidget {
  const HapusKategori({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HapusKategoriWidget();
  }
}

class HapusKategoriWidget extends StatefulWidget {
  const HapusKategoriWidget({Key? key}) : super(key: key);

  @override
  State<HapusKategoriWidget> createState() => _HapusKategoriWidgetState();
}

class _HapusKategoriWidgetState extends State<HapusKategoriWidget> {
  final FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CFColors.grey,
      appBar: AppBar(
        title: const Text('HAPUS KATEGORI MENU'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<List<CategoryModel>>(
              stream: firebaseService.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dataList = snapshot.data;

                  return ListView.builder(
                    itemCount: dataList!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(dataList[index].category,
                                    style: const TextStyle(fontSize: 15)),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "Delete Kategori",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                "Apakah Anda Yakin Ingin menghapus Kategori ini ?",
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("CANCEL"),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      context
                                                          .read<
                                                              CategoryRepository>()
                                                          .deleteCategory(
                                                              dataList[index]
                                                                  .categoryId
                                                                  .toString())
                                                          .then((value) {
                                                        ScaffoldMessenger.of(
                                                            context)
                                                          ..hideCurrentSnackBar()
                                                          ..showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  'Kategori Berhasil Dihapus'),
                                                            ),
                                                          );
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("DELETE"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.delete),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            height: 2,
                            thickness: 1.5,
                          )
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return const CircularProgressIndicator();
              })),
    );
  }
}
