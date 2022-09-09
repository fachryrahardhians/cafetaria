import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';

class HomeItemOrder extends StatelessWidget {
  const HomeItemOrder({
    Key? key,
    required this.image,
    required this.title,
    required this.route,
    this.total = 0,
  }) : super(key: key);

  final String image;
  final String title;
  final int total;
  final VoidCallback route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: route,
      child: Container(
        height: 120,
        padding: const EdgeInsets.only(right: 15),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 75,
              height: 75,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.grey3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  if (total > 0)
                    Align(
                      alignment: Alignment.topRight,
                      child: ClipOval(
                        child: Container(
                          width: 30,
                          height: 30,
                          color: MyColors.red1,
                          padding: const EdgeInsets.all(2),
                          child: const Center(
                            child: Text(
                              "4",
                              style: TextStyle(
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 75,
              height: 40,
              padding: const EdgeInsets.only(right: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
