import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePageBodyInkWell extends StatelessWidget {

  final String imageSrc;
  final String name;
  final String namedRoute;

  const HomePageBodyInkWell({
    required this.imageSrc,
    required this.name,
    required this.namedRoute,
    super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
                        onTap: () {
                          Modular.to.pushNamed(namedRoute);
                        }, // Handle your callback.
                        splashColor: Colors.brown.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Ink(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(imageSrc),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
  }
}