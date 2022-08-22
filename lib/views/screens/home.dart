import 'package:bmi_flutter/util/Gender.dart';
import 'package:bmi_flutter/util/calculator.dart';
import 'package:bmi_flutter/views/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:bmi_flutter/resources/strings.dart';
import 'package:bmi_flutter/resources/app_constants.dart';
import 'package:bmi_flutter/widgets/PickCard.dart';
import 'package:bmi_flutter/widgets/Toggle.dart';
import 'package:bmi_flutter/presenter/HomePresenter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final HomePresenter presenter;

  const HomeScreen({required this.presenter, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeView {

  final pageController = PageController();
  bool isLastPage = false;
  final FixedExtentScrollController _scrollController =
  FixedExtentScrollController(initialItem: initialWeight);

  Gender _selectedGender = Gender.male;
  double _height = initialHeight;
  String _height_str = initialHeight.toInt().toString();
  int _weight = initialWeight;
  String _weight_str = initialWeight.toString();

  @override
  void initState() {
    super.initState();
    widget.presenter.homeView = this;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void updateGender(Gender setGender) {
    setState(() {
      _selectedGender = setGender;
    });
  }
  @override
  void updateHeight(double height) {
    setState(() {
      _height = height;
      _height_str = _height.toInt().toString();
    });
  }
  @override
  void updateWeight(int weight) {
    setState(() {
      _weight = weight;
      _weight_str = _weight.toString();
    });
  }

  @override
  void navigateToResult(String bmi, String result, String description, int genderIndex) {
    Navigator.pushNamed(
        context, '/result',
        arguments: {
          resultBmiParameter: bmi,
          resultResultParameter: result,
          resultDescriptionParameter: description,
          resultGenderParameter: genderIndex
        }
    );
  }

  void handleGenderSelected(Gender gender){
    widget.presenter.onGenderSelected(gender);
  }

  void handleWeightSelected(int weight){
    widget.presenter.onWeightSelected(weight);
  }

  void handleHeightSelected(double height){
    widget.presenter.onHeightSelected(height);
  }

  @override
  Widget build(BuildContext context) {
    var genderImage = isSelectedMale() ? 'assets/male.svg' : 'assets/female.svg';
    var sliderActiveColor = isSelectedMale() ? maleDarkColor : femaleDarkColor;
    var sliderInactiveColor = isSelectedMale() ? maleLightColor : femaleLightColor;
    var sliderThumbColor = isSelectedMale() ? blue : pink;

    var appBar = AppBar(
      backgroundColor: backgroundLight,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        Strings.appBarTitle,
        style: TextStyle(
            color: appBarTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
    );

    var pageGender = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Row(
              children: [

                Expanded(
                  child: PickCard(
                    color: isSelectedMale()
                        ? maleDarkColor
                        : inactiveGray,
                    child: SvgPicture.asset('assets/male.svg'),
                    onTap: () {
                      handleGenderSelected(Gender.male);
                    },
                  ),
                ),
                Expanded(
                    child: PickCard(
                      color: isSelectedMale()
                          ? inactiveGray
                          : femaleDarkColor,
                      child: SvgPicture.asset('assets/female.svg'),
                      onTap: () {
                        setState(() {
                          handleGenderSelected(Gender.female);
                        });
                      },
                    )
                )
              ],
            )
        ),

        Toggle(
          selectedGender: _selectedGender,
          values: genderList,
          onToggle: (index) {
            if (index == 0) {
              handleGenderSelected(Gender.male);
            } else {
              handleGenderSelected(Gender.female);
            }
            setState(() {});
          },
          backgroundColor: inActiveDotColor,
        ),

      ],
    );

    var pageHeight = Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Your height:',
            style: TextStyle(
                color: appBarTextColor,
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            _height_str + Strings.heightUnit,
            style: TextStyle(
                color: sliderActiveColor,
                fontSize: 35,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(top: 10)
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        child: SvgPicture.asset(
                          genderImage,
                          height: _height*1.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                RotatedBox(
                  quarterTurns: 3,
                  child: SliderTheme(

                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: sliderActiveColor,
                      inactiveTrackColor: sliderInactiveColor,
                      trackShape: const RoundedRectSliderTrackShape(),
                      trackHeight: 6.0,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: sliderThumbColor,
                      overlayColor: sliderThumbColor.withAlpha(32),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
                      tickMarkShape: const RoundSliderTickMarkShape(),
                      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: sliderThumbColor,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,),
                    ),
                    child: Slider(
                        value: _height,
                        min: minHeight,
                        max: maxHeight,
                        divisions: (maxHeight-minHeight).toInt(),
                        label: _height_str,
                        onChanged: (value) {
                          handleHeightSelected(value);
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    var pageWeight = Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            Strings.yourWeight,
            style: TextStyle(
                color: appBarTextColor,
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            _weight_str+Strings.weightUnit,
            style: TextStyle(
                color: sliderActiveColor,
                fontSize: 35,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: RotatedBox(
              quarterTurns: -1,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Center(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SvgPicture.asset(
                        isSelectedMale() ? 'assets/scale_male.svg' : 'assets/scale_female.svg',
                        height: MediaQuery.of(context).size.height/2.5,
                        width: MediaQuery.of(context).size.width/2,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width/2,
                        child: ListWheelScrollView(
                          magnification: 2.0,
                          offAxisFraction: 0.45,
                          squeeze: 0.8,
                          onSelectedItemChanged: (x) {
                            handleWeightSelected(x+minWeight);
                          },
                          controller: _scrollController,
                          itemExtent: 60.0,
                          children: List.generate(
                            (maxWeight-minWeight),
                                (index) =>
                                RotatedBox(
                                  quarterTurns: 1,
                                  child:
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 250),
                                    style: TextStyle(
                                      color: index+minWeight == _weight ? Colors.red : Colors.white,
                                      fontSize: index+minWeight == _weight ? 32 : 25,
                                      fontWeight: index+minWeight == _weight ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    child:
                                    Text(
                                      '${index+minWeight}',
                                    ),
                                  ),

                                ),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ],
    );

    var pageView = PageView(
      controller: pageController,
      onPageChanged: (int page) {
        if (page == 2) {
          _scrollController.jumpToItem( _weight - minWeight );
        }
      },
      children: [
        pageGender,

        pageHeight,

        pageWeight,
      ],
    );

    var bottomNavBar = Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      height: 20.0,
      child: Center(
        child: SmoothPageIndicator(
          controller: pageController,
          count: 3,
          effect: const WormEffect(
              dotColor: inActiveDotColor,
              activeDotColor: activeDotColor
          ),
        ),
      ),
    );

    var fab = ElevatedButton(
      onPressed: () {
        if (pageController.page == 2) {
          pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );

          widget.presenter.onCalculateClicked();

        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,);

        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(blue),
      ),
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: pageView,
      ),
      bottomNavigationBar: bottomNavBar,
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  bool isSelectedMale() {
    return _selectedGender == Gender.male;
  }
}

