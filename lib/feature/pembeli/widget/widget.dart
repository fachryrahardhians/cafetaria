import 'package:cafetaria/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class BottomBar extends StatelessWidget {
  BottomBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Pesan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Riwayat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      currentIndex: index,
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Colors.white,
      selectedItemColor: MyColors.red1,
      unselectedItemColor: MyColors.grey2,
      onTap: null,
    );
  }
}

class CustomBoxPicker extends StatelessWidget {
  CustomBoxPicker({
    Key? key,
    required this.onTap,
    this.photo,
    this.label,
    this.hint,
    this.icon,
    this.child,
  }) : super(key: key);

  XFile? photo;
  String? label;
  String? hint;
  Function() onTap;
  Widget? child;
  Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label ?? "",
              style: const TextStyle(
                  fontSize: 13,
                  color: MyColors.grey1,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: MyColors.whiteGrey1,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                        blurRadius: 1,
                      ),
                    ]),
                child: child != null
                    ? Center(
                        child: child,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Visibility(visible: icon != null, child: icon!),
                            const SizedBox(height: 12),
                            Text(hint ?? "")
                          ]))
          ],
        ));
  }
}
