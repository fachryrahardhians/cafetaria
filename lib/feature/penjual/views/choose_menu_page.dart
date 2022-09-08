import 'package:cafetaria/feature/penjual/views/add_opsi_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

class ChooseMenuPage extends StatefulWidget {
  const ChooseMenuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooseMenuPageState();
}

class _ChooseMenuPageState extends State<ChooseMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PILIH MENU'),
        iconTheme: const IconThemeData(color: Colors.red),
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
                SizedBox(
                  height: 44,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefix: const Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/info.png'),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Pilih menu yang ingin ditambah opsi menu',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: 5,
                //   itemBuilder: (context, index) {
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            offset: Offset(0, 4),
                            blurRadius: 12,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: const Text('Nasi Ayam Panggang'),
                        subtitle: const Text('Rp25.000'),
                        leading: Image.asset('assets/images/product-1.png'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListOpsiMenuPage(
                                  menu: MenuModel(tags: ['tags'])),
                            ),
                          );
                        },
                      ),
                  //   );
                  // },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListOpsiMenuPage extends StatefulWidget {
  const ListOpsiMenuPage({Key? key, required this.menu}) : super(key: key);
  final MenuModel menu;

  @override
  State<StatefulWidget> createState() => _ListOpsiMenuState();
}

class _ListOpsiMenuState extends State<ListOpsiMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opsi Menu ${widget.menu.name}'.toUpperCase()),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/no-menu.png'),
              Text(
                'Anda belum memiliki opsi menu untuk ${widget.menu.name}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddOpsiMenuPage(
                  menuId: '',
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            minimumSize: const Size.fromHeight(44),
          ),
          child: const Text(
            'TAMBAH OPSI MENU',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
