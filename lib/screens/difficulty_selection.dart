// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import "dart:math" as math;

import 'package:guiter_app/screens/interest_selection.dart';

class DifficultySelectionScreen extends StatefulWidget {
  DifficultySelectionScreen({super.key});

  @override
  State<DifficultySelectionScreen> createState() =>
      _DifficultySelectionScreenState();
}

class _DifficultySelectionScreenState extends State<DifficultySelectionScreen>
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
      position1 = 0;
      position2 = 0;
      position3 = 0;
      for (int i = 0; i < slides.length; i++) {
        await Future.delayed(Duration(milliseconds: 500));
        listController.currentState!.insertItem(i);
      }
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
                  'What is your',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                ),
              ),
              AnimatedSlide(
                offset: Offset(position2, 0),
                duration: const Duration(seconds: 1),
                child: Text(
                  'level?',
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
                  'We will adapt the app to your level',
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
          child: AnimatedList(
            physics: NeverScrollableScrollPhysics(),
            key: listController,
            padding: EdgeInsets.all(15),
            itemBuilder: (context, index, animation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          position1 = -3;
                          position2 = -3;
                          position3 = -3;
                        });
                        await Future.delayed(Duration(milliseconds: 200));
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return InterestSelectionScreen();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: slides[index]['color'],
                          child: Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  slides[index]['title'],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(slides[index]['content'])
                              ],
                            ),
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
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
}
