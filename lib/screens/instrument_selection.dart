// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guiter_app/screens/difficulty_selection.dart';
import 'package:guiter_app/utils/image_paths.dart';
import "dart:math" as math;

class InstrumentSelectionScreen extends StatefulWidget {
  void Function() change;
  InstrumentSelectionScreen({super.key, required this.change});

  @override
  State<InstrumentSelectionScreen> createState() =>
      _InstrumentSelectionScreenState();
}

class _InstrumentSelectionScreenState extends State<InstrumentSelectionScreen>
    with TickerProviderStateMixin {
  PageController pageController = PageController(
    viewportFraction: 0.7,
  );
  final List<PageViewItem> pages = [
    PageViewItem(name: 'Guitar One', image: ImagePath.guiterOne, index: 0),
    PageViewItem(name: 'Guitar Two', image: ImagePath.guiterTwo, index: 1),
    PageViewItem(name: 'Guitar Three', image: ImagePath.guiterThree, index: 2),
    PageViewItem(name: 'Guitar Four', image: ImagePath.guiterOne, index: 3),
    PageViewItem(name: 'Guitar Five', image: ImagePath.guiterTwo, index: 4)
  ];

  int currPage = 0;
  late AnimationController tapAnimationController;
  late AnimationController slideAnimationController1;
  late AnimationController slideAnimationController2;

  @override
  void initState() {
    tapAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    slideAnimationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    slideAnimationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffdfb),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                  animation: slideAnimationController1,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(slideAnimationController1.value * -400, 0),
                      child: Text(
                        'What Instrument',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w800),
                      ),
                    );
                  }),
              AnimatedBuilder(
                  animation: slideAnimationController1,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(slideAnimationController1.value * -400, 0),
                      child: const Text(
                        'do you play?',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w800),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              AnimatedBuilder(
                  animation: slideAnimationController2,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(slideAnimationController2.value * -400, 0),
                      child: const Text(
                        'You can change it at anytime',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    );
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        padEnds: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: pages.length,
                        pageSnapping: true,
                        onPageChanged: (value) {
                          setState(() {
                            currPage = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                              animation: tapAnimationController,
                              builder: (context, child) {
                                return AnimatedRotation(
                                  turns: calculateAngle(
                                      currentPage: currPage,
                                      page: pages[index]),
                                  duration: Duration(milliseconds: 300),
                                  child: InkWell(
                                    onTap: () async {
                                      widget.change.call();
                                      tapAnimationController
                                          .animateTo(0.1)
                                          .then((value) =>
                                              tapAnimationController
                                                  .animateTo(0));
                                      slideAnimationController1.forward();
                                      await Future.delayed(
                                          Duration(milliseconds: 100));
                                      slideAnimationController2
                                          .forward()
                                          .then((value) {
                                        // Navigator.of(context)
                                        //     .push(PageRouteBuilder(
                                        //   pageBuilder: (context, animation,
                                        //       secondaryAnimation) {
                                        //     return DifficultySelction();
                                        //   },
                                        // ));
                                      });
                                    },
                                    child: AnimatedScale(
                                      duration: Duration(milliseconds: 200),
                                      scale: calculateScale(
                                          currentPage: currPage,
                                          page: pages[index]),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        margin: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            bottom:
                                                currPage == pages[index].index
                                                    ? 50
                                                    : 0),
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade500,
                                                      offset: Offset(0, 10),
                                                      blurRadius: 1,
                                                      spreadRadius: 1)
                                                ],
                                                color: Color(0xfffbefcd),
                                              ),
                                              alignment: Alignment.bottomCenter,
                                              margin: const EdgeInsets.only(
                                                  top: 80,
                                                  left: 5,
                                                  right: 5,
                                                  bottom: 5),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15),
                                                child: Text(
                                                  pages[index].name,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            )),
                                            Positioned.fill(
                                                child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 50),
                                              child: Transform.rotate(
                                                angle: math.pi * 15 / 180,
                                                child: Image.asset(
                                                  pages[index].image,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    SizedBox(
                        height: 10,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: pages
                                .map((e) => AnimatedContainer(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      duration: Duration(milliseconds: 300),
                                      decoration: BoxDecoration(
                                          color: currPage ==
                                                  pages.indexWhere((element) =>
                                                      element.index == e.index)
                                              ? Colors.black
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      width: currPage ==
                                              pages.indexWhere((element) =>
                                                  element.index == e.index)
                                          ? 50
                                          : 10,
                                    ))
                                .toList()))
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  double calculateAngle({
    required PageViewItem page,
    required int currentPage,
  }) {
    if (page.index > currPage) {
      return 0.02;
    } else if (page.index < currPage) {
      return -0.02;
    }

    return 0;
  }

  double calculateScale(
      {required int currentPage, required PageViewItem page}) {
    if (page.index != currPage) {
      return 0.8;
    } else {
      return 1 + tapAnimationController.value;
    }
  }
}

class PageViewItem {
  String name;
  String image;
  int index;

  PageViewItem({
    required this.name,
    required this.image,
    required this.index,
  });
}
