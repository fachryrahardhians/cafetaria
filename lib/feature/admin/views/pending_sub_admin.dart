import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class PendingSubAdmin extends StatelessWidget {
  const PendingSubAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PendingSubAdminWidget();
  }
}

class PendingSubAdminWidget extends StatefulWidget {
  const PendingSubAdminWidget({Key? key}) : super(key: key);

  @override
  State<PendingSubAdminWidget> createState() => _PendingSubAdminWidgetState();
}

class _PendingSubAdminWidgetState extends State<PendingSubAdminWidget> {
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(columns: const <DataColumn>[
                DataColumn(label: Text("nama")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("Kawasan")),
                DataColumn(label: Text("Action"))
              ], rows: <DataRow>[
                DataRow(cells: <DataCell>[
                  const DataCell(Text("M. Tegar")),
                  const DataCell(Text("mtegarph@gmail.com")),
                  const DataCell(Text("Pamulang")),
                  DataCell(
                    const Text("Pending"),
                    onTap: () {
                      print("DATA 1");
                    },
                  ),
                ]),
                const DataRow(cells: <DataCell>[
                  DataCell(Text("Adam Muhammad")),
                  DataCell(Text("adam@gmail.com")),
                  DataCell(Text("Bandung")),
                  DataCell(Text("Pending")),
                ]),
                const DataRow(cells: <DataCell>[
                  DataCell(Text("Rifqy Fadhli")),
                  DataCell(Text("rifqy@gmail.com")),
                  DataCell(Text("Bintaro")),
                  DataCell(Text("Pending")),
                ])
              ]),
            )
          ],
        ),
      ),
    );
  }
}
