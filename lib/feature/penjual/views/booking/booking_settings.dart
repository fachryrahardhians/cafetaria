import 'package:cafetaria/feature/penjual/model/preorder.dart';
import 'package:cafetaria/feature/penjual/views/booking/controller/booking_controller.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingSettingsPage extends StatelessWidget {
  BookingSettingsPage({Key? key, this.preOrder}) : super(key: key);

  final PreOrder? preOrder;

  final bookC = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    if (preOrder != null) {
      bookC.showPorsi.value = preOrder!.isShowPublic ?? true;
      bookC.jarakC.text = preOrder!.poDay.toString();
      bookC.maxPorsiC.text = preOrder!.maxQty.toString();
      bookC.selectedTime = DateTime.parse(preOrder!.pickupTime!);
      bookC.checkDone();
    }
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
                  controller: bookC.jarakC,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => bookC.checkDone(),
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
                  controller: bookC.maxPorsiC,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) => bookC.checkDone(),
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
                    bookC.aturJamPengambilan(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<BookingController>(
                        builder: (c) {
                          return Text(
                            c.selectedTime == null
                                ? "Atur jam pengambilan"
                                : DateFormat.Hm().format(c.selectedTime!),
                            style: TextStyle(
                              fontSize: 16,
                              color: c.selectedTime == null
                                  ? MyColors.grey3
                                  : MyColors.blackText,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
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
                    fixedSize: Size(Get.width, 60),
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
                    bookC.showPorsi.value = true;
                  },
                  child: Row(
                    children: [
                      Obx(
                        () => Icon(
                          bookC.showPorsi.isTrue
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: bookC.showPorsi.isTrue
                              ? MyColors.red1
                              : MyColors.grey3,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text("Batasan porsi terlihat"),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    bookC.showPorsi.value = false;
                  },
                  child: Row(
                    children: [
                      Obx(
                        () => Icon(
                          bookC.showPorsi.isTrue
                              ? Icons.radio_button_off
                              : Icons.radio_button_checked,
                          color: bookC.showPorsi.isTrue
                              ? MyColors.grey3
                              : MyColors.red1,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text("Batasan porsi sembunyikan"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: SizedBox(
              width: Get.width,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (bookC.isDone.isTrue && bookC.selectedTime != null) {
                      if (preOrder != null) {
                        await bookC.editSettingBooking();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Get.delete<BookingController>();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Berhasil mengubah booking")));
                      } else {
                        await bookC.addBooking();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Get.delete<BookingController>();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Berhasil tambah booking")));
                      }
                    }
                  },
                  child: const Text("SIMPAN"),
                  style: ElevatedButton.styleFrom(
                    primary: bookC.isDone.isTrue && bookC.selectedTime != null
                        ? MyColors.red1
                        : MyColors.disabledRed1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
