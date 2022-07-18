import 'package:cafetaria/feature/penjual/views/booking/atur_booking_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BOOKING'),
        centerTitle: true,
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
            child: FutureBuilder(
              builder: (context, snap) {
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

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: 10,
                  itemBuilder: (context, index) {
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
                            const Text(
                              "CATEGORY ...",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Jarak Booking : 2 Hari",
                              style: TextStyle(
                                color: MyColors.grey3,
                              ),
                            ),
                            const Text(
                              "Maksimal Porsi : 4 Porsi",
                              style: TextStyle(
                                color: MyColors.grey3,
                              ),
                            ),
                            const Text(
                              "Jam Pengambilan : 18:00",
                              style: TextStyle(
                                color: MyColors.grey3,
                              ),
                            ),
                            const Text(
                              "Batasan porsi : 'Terlihat'",
                              style: TextStyle(
                                color: MyColors.grey3,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\u2022 Nama ${index + 1}",
                                    style: const TextStyle(
                                      color: MyColors.grey3,
                                    ),
                                  ),
                                  const Text(
                                    "Rp 20.000",
                                    style: TextStyle(
                                      color: MyColors.blackText,
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
                                    // OPEN DIALOG
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
                                  onPressed: () {},
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
                      builder: (context) => const AturBookingPage(),
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
