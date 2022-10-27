// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import "dart:math" as math;

import 'package:guiter_app/screens/interest_selection.dart';

class InterestSelectionScreen extends StatefulWidget {
  InterestSelectionScreen({super.key});

  @override
  State<InterestSelectionScreen> createState() =>
      _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen>
    with TickerProviderStateMixin {
  PageController pageController = PageController(
    viewportFraction: 0.7,
  );

  int currPage = 0;
  late GlobalKey<AnimatedListState> listController;
  late AnimationController slideAnimationController1;
  late AnimationController slideAnimationController2;

  @override
  void initState() {
    listController = GlobalKey<AnimatedListState>();
    slideAnimationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    slideAnimationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animateToScreen();
    super.initState();
  }

  double position1 = 3;
  double position2 = 3;
  double position3 = 3;
  List<Map<String, dynamic>> slides = [
    {
      'title': 'Elementary',
      'content': 'I have never played before',
      'color': Color.fromARGB(255, 201, 246, 224)
    },
    {
      'title': 'Basic',
      'content': 'I can play a few songs',
      'color': Color.fromARGB(255, 242, 242, 197)
    },
    {
      'title': 'Expert',
      'content': 'I can play almost everything',
      'color': Color.fromARGB(255, 244, 213, 249)
    }
  ];
  animateToScreen() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        position1 = 0;
        position2 = 0;
        position3 = 0;
      });
    });
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
              AnimatedSlide(
                offset: Offset(position1, 0),
                duration: const Duration(seconds: 1),
                child: Text(
                  'Choose your',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                ),
              ),
              AnimatedSlide(
                offset: Offset(position2, 0),
                duration: const Duration(seconds: 1),
                child: Text(
                  'interests',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedSlide(
                offset: Offset(position3, 0),
                duration: const Duration(seconds: 1),
                child: Text(
                  'To make your feed more personalized',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: AnimatedSlide(
              offset: Offset(0, position3),
              duration: const Duration(milliseconds: 1000),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      30,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: math.Random().nextDouble() * 20,
                                ),
                                child: Text('Random'),
                                height: 30,
                              ),
                            ),
                          )),
                ),
              ),
            )),
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
}
