import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class BookingSettingsPage extends StatelessWidget {
  BookingSettingsPage({Key? key}) : super(key: key);

  final TextEditingController jarakC = TextEditingController();
  final TextEditingController maxPorsiC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATUR BOOKING'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  "JARAK BOOKING DARI PENGAMBILAN",
                  style: TextStyle(
                    color: MyColors.grey3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: jarakC,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: MyColors.grey3),
                    hintText: "Masukkan jarak booking",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.grey3,
                      ),
                    ),
                    suffixText: "Hari",
                    suffixStyle: TextStyle(
                      color: MyColors.blackText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Dihitung dari hari setelah booking",
                  style: TextStyle(
                    color: MyColors.grey3,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "MAKSIMAL PORSI",
                  style: TextStyle(
                    color: MyColors.grey3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: maxPorsiC,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: MyColors.grey3),
                    hintText: "Masukkan maksimal porsi",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.grey3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "JAM PENGAMBILAN",
                  style: TextStyle(
                    color: MyColors.grey3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    //
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Atur jam pengambilan",
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColors.grey3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.access_time,
                          color: MyColors.red1,
                        ),
                      )
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 60),
                    side: const BorderSide(
                      color: MyColors.grey3,
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Batasan Porsi",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text("Atur batasan porsi?"),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    //
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.radio_button_checked,
                        color: MyColors.red1,
                      ),
                      SizedBox(width: 5),
                      Text("Batasan porsi terlihat"),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    //
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.radio_button_checked,
                        color: MyColors.red1,
                      ),
                      SizedBox(width: 5),
                      Text("Batasan porsi sembunyikan"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //
                },
                child: const Text("SIMPAN"),
                style: ElevatedButton.styleFrom(
                  primary: MyColors.red1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
