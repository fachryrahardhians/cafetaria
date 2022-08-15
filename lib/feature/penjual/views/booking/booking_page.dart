import 'package:cafetaria/feature/penjual/model/menu_model_obs.dart';
import 'package:cafetaria/feature/penjual/views/booking/atur_booking_page.dart';
import 'package:cafetaria/feature/penjual/views/booking/booking_settings.dart';
import 'package:cafetaria/feature/penjual/views/booking/controller/booking_controller.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatelessWidget {
  BookingPage({Key? key}) : super(key: key);

  final bookC = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BOOKING'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.delete<BookingController>();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyColors.red1,
                  ),
                  hintText: "Cari diskon",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: bookC.streamAllBooking(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snap.hasData) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/no-menu.png"),
                        const SizedBox(height: 10),
                        const Text(
                          "Anda belum memiliki menu",
                          style: TextStyle(
                            color: MyColors.grey3,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (snap.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/no-menu.png"),
                        const SizedBox(height: 10),
                        const Text(
                          "Anda belum memiliki menu",
                          style: TextStyle(
                            color: MyColors.grey3,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                bookC.addAllDocBooking(snap.data!.docs);

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: bookC.booking.length,
                  itemBuilder: (context, index) {
                    List<MenuModelObs> menuByCategory = bookC.booking[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FutureBuilder<String>(
                              future: bookC.getCategoryName(bookC.allCategoryBooking[index]),
                              builder: (context, snapCat) {
                                if (snapCat.connectionState == ConnectionState.waiting) {
                                  return const Text(
                                    "LOADING...",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                return Text(
                                  snapCat.data!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                            FutureBuilder(
                              future: bookC.getOrderTime(),
                              builder: (context, snapTime) {
                                if (snapTime.connectionState == ConnectionState.waiting) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: const [
                                      Text(
                                        "Jarak Booking : - Hari",
                                        style: TextStyle(
                                          color: MyColors.grey2,
                                        ),
                                      ),
                                      Text(
                                        "Maksimal Porsi : - Porsi",
                                        style: TextStyle(
                                          color: MyColors.grey2,
                                        ),
                                      ),
                                      Text(
                                        "Jam Pengambilan : -",
                                        style: TextStyle(
                                          color: MyColors.grey2,
                                        ),
                                      ),
                                      Text(
                                        "Batasan porsi : -",
                                        style: TextStyle(
                                          color: MyColors.grey2,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  );
                                }

                                if (snapTime.hasError) {
                                  return const SizedBox();
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Jarak Booking : ${bookC.preOrder?.poDay ?? '-'} Hari",
                                      style: const TextStyle(
                                        color: MyColors.grey2,
                                      ),
                                    ),
                                    Text(
                                      "Maksimal Porsi : ${bookC.preOrder?.maxQty ?? '-'} Porsi",
                                      style: const TextStyle(
                                        color: MyColors.grey2,
                                      ),
                                    ),
                                    Text(
                                      "Jam Pengambilan : ${bookC.preOrder?.pickupTime == null ? '-' : DateFormat.Hm().format(DateTime.parse(bookC.preOrder!.pickupTime!))}",
                                      style: const TextStyle(
                                        color: MyColors.grey2,
                                      ),
                                    ),
                                    Text(
                                      "Batasan porsi : ${bookC.preOrder == null ? '-' : bookC.preOrder!.isShowPublic == true ? 'Terlihat' : 'Disembunyikan'}",
                                      style: const TextStyle(
                                        color: MyColors.grey2,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                );
                              },
                            ),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: menuByCategory.length,
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\u2022 ${menuByCategory[index].name}",
                                    style: const TextStyle(
                                      color: MyColors.grey2,
                                    ),
                                  ),
                                  Text(
                                    "Rp ${menuByCategory[index].price}",
                                    style: const TextStyle(
                                      color: MyColors.grey2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "Delete Booking",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                "Are you sure to delete all item in this booking?",
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("CANCEL"),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      bookC.deleteBooking(menuByCategory);
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
                                  child: const Text(
                                    "Hapus",
                                    style: TextStyle(
                                      color: MyColors.red1,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Edit Menu",
                                    style: TextStyle(
                                      color: MyColors.red1,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await bookC.getOrderTime();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BookingSettingsPage(preOrder: bookC.preOrder),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: MyColors.red1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AturBookingPage(),
                    ),
                  );
                },
                child: const Text("TAMBAH BOOKING"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
