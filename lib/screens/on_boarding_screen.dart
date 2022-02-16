import 'package:amazon/controller/cache_helper/shared_prefernces.dart';
import 'package:amazon/models/boarding_model.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/shoponline4.jpg',
      title: 'tite 1',
      body: 'body 1',
    ),
    BoardingModel(
      image: 'assets/images/shoponline3.jpg',
      title: 'tite 2',
      body: 'body2',
    ),
    BoardingModel(
      image: 'assets/images/shoponline2.jpg',
      title: 'tite 3',
      body: 'body 3',
    ),
  ];

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () {
              CacheHelper.saveData(key: 'onBoarding', value: true)
                  .then((value) {
                if (value) {
                  navigateAndFinish(context, LoginScreen());
                }
              });
            },
            text: 'SKIP',
            size: 17,
          )
          // TextButton(
          //   onPressed: () {
          //     navigateTo(context, LoginScreen());
          //   },
          //   child: Text('SKIP'),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (value) {
                  if (value == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.deepPurpleAccent,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateTo(context, LoginScreen());
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                  mini: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
            // fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
