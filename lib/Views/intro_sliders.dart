import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Route_managements/routes.dart';
import 'package:kolazz_book/Utils/colors.dart';


class IntroSlider extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<IntroSlider>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  List slideList = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
    Future.delayed(Duration(seconds: 4), (){
      Get.toNamed(dashbord);
    });

     Future.delayed(Duration.zero, () {
      setState(() {
        slideList = [
          Slide(
            imageUrl: 'assets/images/intro1.png',
            title: 'Title 1',
            description: "Description 1",
          ),
          Slide(
            imageUrl: 'assets/images/intro2.png',
            title: 'Title 2',
            description: 'Description 2',
          ),
          Slide(
            imageUrl: 'assets/images/intro3.png',
            title: 'Title 2',
            description: 'Description 2',
          ),
          // Slide(
          //   imageUrl: 'assets/images/introimage_c.png',
          //   title: getTranslated(context, 'TITLE3_LBL'),
          //   description: getTranslated(context, 'DISCRIPTION3'),
          // ),
        ];
      });
    });

    // buttonController =  AnimationController(
    //     duration:  Duration(milliseconds: 2000), vsync: this);
    //
    // buttonSqueezeanimation =  Tween(
    //   begin: MediaQuery.of(context).size.width * 0.9,
    //   end: 50.0,
    // ).animate(
    //     CurvedAnimation(
    //   parent: buttonController!,
    //   curve:  Interval(
    //     0.0,
    //     0.150,
    //   ),
    // ));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    buttonController!.dispose();

    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  _onPageChanged(int index) {
    if (mounted)
      setState(() {
        _currentPage = index;
      });
  }

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Widget _slider() {
    return PageView.builder(
      itemCount: slideList.length,
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height ,
                child: Image.asset(
                  slideList[index].imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              // Container(
              //     margin: EdgeInsetsDirectional.only(top: 20),
              //     child: Text(slideList[index].title,
              //         style: Theme.of(context).textTheme.headline5!.copyWith(
              //             color: Colors.black12,
              //             fontWeight: FontWeight.bold))),
              // Container(
              //   padding: EdgeInsetsDirectional.only(
              //       top: 30.0, start: 15.0, end: 15.0),
              //   child: Text(slideList[index].description,
              //       textAlign: TextAlign.center,
              //       style: Theme.of(context).textTheme.subtitle1!.copyWith(
              //           color: Colors.black12,
              //           fontWeight: FontWeight.normal)),
              // ),
            ],
          ),
        );
      },
    );
  }


  List<Widget> getList() {
    List<Widget> childs = [];

    for (int i = 0; i < slideList.length; i++) {
      childs.add(Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i
                ? Colors.black
                : Colors.black.withOpacity((0.5)),
          )));
    }
    return childs;
  }

  skipBtn() {
    return _currentPage == 0 || _currentPage == 1
        ? Padding(
        padding: EdgeInsetsDirectional.only(top: 20.0, end: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                // setPrefrenceBool(ISFIRSTTIME, true);
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignInUpAcc()),
                // );
              },
              child: Row(children: [
                Text("SKIP",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.black,
                    )),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 12.0,
                ),
              ]),
            ),
          ],
        ))
        : Container(
      margin: EdgeInsetsDirectional.only(top: 50.0),
      height: 15,
    );
  }




  @override
  Widget build(BuildContext context) {
    // deviceHeight = MediaQuery.of(context).size.height;
    // deviceWidth = MediaQuery.of(context).size.width;
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: AppColors.back,
        body: Stack(
          alignment: Alignment.bottomCenter,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // skipBtn(),
            _slider(),
        Positioned(
          bottom: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getList()),
              // Center(
              //     child: Padding(
              //       padding: const EdgeInsetsDirectional.only(bottom: 18.0),
              //       child: AppBtn(
              //           title: _currentPage == 0 || _currentPage == 1
              //               ? getTranslated(context, 'NEXT_LBL')
              //               : getTranslated(context, 'GET_STARTED'),
              //           btnAnim: buttonSqueezeanimation,
              //           btnCntrl: buttonController,
              //           onBtnSelected: () {
              //             if (_currentPage == 2) {
              //               setPrefrenceBool(ISFIRSTTIME, true);
              //               Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(builder: (context) => SignInUpAcc()),
              //               );
              //             } else {
              //               _currentPage = _currentPage + 1;
              //               _pageController.animateToPage(_currentPage,
              //                   curve: Curves.decelerate,
              //                   duration: Duration(milliseconds: 300));
              //             }
              //           }),
              //     )),
            ],
          ),
        ),
            // _btn(),
          ],
        ));
  }
}

class Slide {
  final String imageUrl;
  final String? title;
  final String? description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}
