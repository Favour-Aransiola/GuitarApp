import 'package:flutter/material.dart';
import 'package:guiter_app/screens/difficulty_selection.dart';
import 'package:guiter_app/screens/instrument_selection.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  CrossFadeState state = CrossFadeState.showFirst;
  changeState() {
    setState(() {
      state = CrossFadeState.showSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedCrossFade(
          firstChild: InstrumentSelectionScreen(change: changeState),
          secondChild: DifficultySelectionScreen(),
          crossFadeState: state,
          duration: Duration(seconds: 2)),
    );
  }
}
