import 'package:flutter/material.dart';

class HomePageProgBar extends StatelessWidget {

  final int currentValue;
  final int planning;

  const HomePageProgBar({
    required this.currentValue,
    required this.planning,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          height: 15,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                flex: currentValue~/(planning/100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade900,
                                    border: Border.all(
                                      color: Colors.blue.shade900,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  height: 15,
                                ),
                              ),
                              Flexible(
                                flex: 100 - currentValue~/(planning/100),
                                child: Container(),
                              ),
                            ],
                          ),
                        );
  }
}