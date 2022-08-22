import 'package:flutter/material.dart';
import 'package:bmi_flutter/util/Gender.dart';

class SexToggle extends StatelessWidget {
  const SexToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Toggle extends StatelessWidget {
  final List<String> values;
  final Gender selectedGender;
  final ValueChanged onToggle;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final List<BoxShadow> shadows;

  const Toggle({
    required this.values,
    required this.onToggle,
    required this.selectedGender,
    this.backgroundColor = const Color(0xffffffff),
    this.buttonColor = const Color(0xffffffff),
    this.textColor = const Color(0xff000000),
    this.shadows = const [
      BoxShadow(
        color: Color(0xffffffff),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 0),
      ),
    ],
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.7,
      height: width * 0.13,
      margin: const EdgeInsets.all(25.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              onToggle(selectedGender == Gender.male ? 1 : 0);
            },
            child: Container(
              width: width * 0.7,
              height: width * 0.13,
              decoration: ShapeDecoration(
                color: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List
                    .generate(
                  values.length,
                      (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Text(
                      values[index],
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: textColor
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
            selectedGender.index == Gender.male.index ? Alignment.centerLeft : Alignment.centerRight,
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  onToggle(1);
                }

                if (details.delta.dx < 0) {
                  onToggle(0);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: width * 0.35,
                height: width * 0.12,
                decoration: ShapeDecoration(
                  color: buttonColor,
                  shadows: shadows,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.1),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  selectedGender == Gender.male ? values[0] : values[1],
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: width * 0.05,
                      color: textColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
