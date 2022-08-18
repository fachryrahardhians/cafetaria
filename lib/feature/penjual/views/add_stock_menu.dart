import 'package:flutter/material.dart';

class AddStockMenuPage extends StatefulWidget {
  const AddStockMenuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddStockMenuPageState();
}

class _AddStockMenuPageState extends State<AddStockMenuPage> {
  bool stockActive = true;
  bool berulangActive = false;
  List<String> dropdown = ['Setiap Jam', 'Mingguan', 'Harian'];
  String selectedDropdown = 'Setiap Jam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Atur Stok Menu',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      color: Colors.grey,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nasi Ayam Bakar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Rp 25.000',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          '1 opsi menu tersambung',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: stockActive,
                      onChanged: (val) {
                        setState(() {
                          stockActive = val;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'STOK MENU',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  height: 47,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: stockActive ? Colors.white : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.0,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: '100',
                    enabled: stockActive,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Terapkan sebagai berulang',
                    ),
                    Switch(
                      value: berulangActive,
                      onChanged: (val) {
                        setState(() {
                          berulangActive = val;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.green,
                    ),
                  ],
                ),
                Visibility(
                  visible: berulangActive,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      const Text(
                        'ATUR ULANG BATAS PENJUALAN',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        height: 47,
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
                        child: DropdownButtonFormField(
                          value: selectedDropdown,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.red,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Pilih atur ulang batas penjualan',
                          ),
                          items: dropdown.map((e) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                e,
                              ),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'ATUR ULANG PADA JAM',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        height: 47,
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
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Pilih atur ulang pada jam',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(
                                Icons.watch_later_outlined,
                                color: Colors.red,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'PENGISIAN STOK SELANJUTNYA',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Jumat, 5 Maret 2022 pada 08:00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('SIMPAN'),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            tapTargetSize: MaterialTapTargetSize.padded,
          ),
        ),
      ),
    );
  }
}
