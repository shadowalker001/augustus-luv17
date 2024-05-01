import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:luvit/configs/app_auth.dart';
import 'package:luvit/configs/model.dart';
import 'package:luvit/configs/nav_bar.dart';
import 'package:luvit/configs/size_config.dart';
import 'package:luvit/configs/theme.dart';
import 'package:luvit/configs/uiwidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    keepPage: true,
  );
  int _activeImageIndex = 0;
  int selectedTab = 0;
  late DatabaseReference _databaseRef;
  // ignore: unused_field
  List<AppUser> _data = [];

  late List<String> _imageFiles;

  @override
  void initState() {
    _imageFiles = [
      CommonAssets.slide1,
      CommonAssets.slide2,
      CommonAssets.slide3,
      CommonAssets.slide3,
      CommonAssets.slide3,
    ];
    _databaseRef = AppAuth().databaseRef.child('data');
    _databaseRef.onValue.listen((event) {
      setState(() {
        _data = [..._parseData(event.snapshot.value)];
      });
    });

    super.initState();
  }

  List<AppUser> _parseData(value) {
    List<AppUser> dataList = [];
    value.forEach((key, data) {
      var valX = maper(data)..addAll({"dataTitle": key});
      dataList.add(AppUser.fromJSON(valX));
    });
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    double widthMultiplier = SizeConfig.widthMultiplier;
    double textMultiplier = SizeConfig.textMultiplier;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double viewHeight = deviceHeight * 0.8;
    double viewWidth = deviceWidth * 0.8;

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 39,
              ),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(width: 3, color: Colors.grey),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 56,
              ),
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 70,
              width: 70,
              child: FloatingActionButton(
                backgroundColor: Colors.grey.shade800,
                elevation: 0,
                onPressed: () {
                  // debugPrint("Add Button pressed");
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 4,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: Colors.black45),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade900,
                        Colors.grey,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ImageIcon(
                    AssetImage(
                      CommonAssets.star,
                    ),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            //
          },
        ),
        extendBody: true,
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
          color: const Color(0xB80E0D0D),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widthMultiplier * 2.5,
                ),
                height: textMultiplier * 10,
                width: deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage(CommonAssets.location),
                            color: Colors.white,
                          ),
                          SizedBox(width: widthMultiplier),
                          Expanded(
                            child: UiWidgets.textItem(
                              '목이길어슬픈기린님의 새로운 스팟',
                              color: Colors.white,
                              mul: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          UiWidgets.boxedItem(
                            '323,233',
                            width: widthMultiplier * 20,
                            height: textMultiplier * 4,
                            mul: 1.5,
                            icon: ImageIcon(
                              AssetImage(
                                CommonAssets.star,
                              ),
                              color: Colors.grey.shade700,
                              size: textMultiplier * 2,
                            ),
                            border: Border.all(color: Colors.grey.shade700),
                          ),
                          SizedBox(width: widthMultiplier),
                          Stack(
                            children: [
                              ImageIcon(
                                AssetImage(CommonAssets.bell),
                                color: Colors.white,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Icon(
                                  Icons.circle,
                                  color: CustomTheme.appColor,
                                  size: 5,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: textMultiplier * 5),
                height: viewHeight,
                width: double.infinity,
                child: _imageFiles.isEmpty
                    ? Container(
                        height: viewHeight,
                        width: viewWidth,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(widthMultiplier * 10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UiWidgets.textItem(
                              '추천 드릴 친구들을 준비 중이에요',
                              isBold: true,
                              mul: 3,
                            ),
                            SizedBox(height: textMultiplier * 1.3),
                            UiWidgets.textItem(
                              '매일 새로운 친구들을 소개시켜드려요',
                              mul: 1.8,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      )
                    : PageView.builder(
                        controller: _pageController,
                        itemCount: _imageFiles.length,
                        onPageChanged: (int page) {
                          setState(() {
                            // _activeImageIndex = 0;
                            _activeImageIndex = page;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.down,
                            onDismissed: (direction) {
                              setState(() {
                                _imageFiles.removeAt(index);
                              });
                            },
                            child: Draggable(
                              onDragEnd: (details) {
                                if ( //
                                    details.offset.dy > 0
                                    //
                                    // ||
                                    //
                                    // details.offset.dx < 0 //
                                    ) {
                                  setState(() {
                                    _imageFiles.removeAt(index);
                                  });
                                }
                              },
                              childWhenDragging: Container(),
                              feedback: Material(
                                borderRadius: BorderRadius.circular(
                                  widthMultiplier * 8,
                                ),
                                child: Container(
                                  height: viewHeight,
                                  width: viewWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      widthMultiplier * 8,
                                    ),
                                  ),
                                  child: Image.asset(
                                    _imageFiles[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  widthMultiplier * 8,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widthMultiplier * 1.5,
                                  ),
                                  child: Container(
                                    height: viewHeight,
                                    width: deviceWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        widthMultiplier * 8,
                                      ),
                                      color: CustomTheme().minorMain,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: double.infinity,
                                      width: deviceWidth,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    _imageFiles[index],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  widthMultiplier * 8,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      widthMultiplier * 5,
                                                  vertical:
                                                      textMultiplier * 2.5,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    UiWidgets.boxedItem(
                                                      '29,930',
                                                      height:
                                                          textMultiplier * 5.5,
                                                      width:
                                                          widthMultiplier * 24,
                                                      mul: 2.3,
                                                      icon: ImageIcon(
                                                        AssetImage(
                                                          CommonAssets.star,
                                                        ),
                                                        color: Colors
                                                            .grey.shade800,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            textMultiplier * 2),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        widthMultiplier *
                                                                            3),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          widthMultiplier *
                                                                              42,
                                                                      child: UiWidgets
                                                                          .textItem(
                                                                        '잭과분홍콩나물',
                                                                        isBold:
                                                                            true,
                                                                        mul:
                                                                            3.5,
                                                                      ),
                                                                    ),
                                                                    UiWidgets
                                                                        .textItem(
                                                                      '25',
                                                                      mul: 3,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        textMultiplier *
                                                                            1.5),
                                                                Visibility(
                                                                  visible:
                                                                      _activeImageIndex ==
                                                                          0,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: UiWidgets
                                                                        .textItem(
                                                                      '서울 · 2km 거리에 있음',
                                                                      mul: 2,
                                                                      color: Colors
                                                                          .white60,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible:
                                                                      _activeImageIndex ==
                                                                          1,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: UiWidgets
                                                                        .textItem(
                                                                      '서로 아껴주고 힘이 되어줄 사람 찾아요 선릉으로 직장 다니고 있고 여행 좋아해요 이상한 이야기하시는 분 바로 차단입니다',
                                                                      mul: 2,
                                                                      color: Colors
                                                                          .white60,
                                                                      visible:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible:
                                                                      _activeImageIndex >=
                                                                          2,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        UiWidgets
                                                                            .boxedItem(
                                                                          '💖 진지한 연애를 찾는 중',
                                                                          mul:
                                                                              2,
                                                                          width:
                                                                              widthMultiplier * 45,
                                                                          height:
                                                                              textMultiplier * 6,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                CustomTheme.appColor,
                                                                          ),
                                                                          boxColor:
                                                                              const Color(0xB8621133),
                                                                          textColor:
                                                                              CustomTheme.appColor,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                textMultiplier),
                                                                        Row(
                                                                          children: [
                                                                            UiWidgets.boxedItem(
                                                                              '🍸 전혀 안 함',
                                                                              mul: 2,
                                                                              width: widthMultiplier * 26,
                                                                              height: textMultiplier * 5.5,
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            UiWidgets.boxedItem(
                                                                              '🚬 비흡연',
                                                                              mul: 2,
                                                                              width: widthMultiplier * 24,
                                                                              height: textMultiplier * 5.5,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                textMultiplier),
                                                                        UiWidgets
                                                                            .boxedItem(
                                                                          '💪🏻 매일 1시간 이상',
                                                                          mul:
                                                                              2,
                                                                          width:
                                                                              widthMultiplier * 34,
                                                                          height:
                                                                              textMultiplier * 5.5,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                textMultiplier),
                                                                        Row(
                                                                          children: [
                                                                            UiWidgets.boxedItem(
                                                                              '🤝 만나는 걸 좋아함',
                                                                              mul: 2,
                                                                              width: widthMultiplier * 36,
                                                                              height: textMultiplier * 5.5,
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            UiWidgets.boxedItem(
                                                                              'INFP',
                                                                              mul: 2,
                                                                              width: widthMultiplier * 15,
                                                                              height: textMultiplier * 5.5,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        UiWidgets.favorite(),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: textMultiplier *
                                                            1.5),
                                                    const Center(
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                _pageController.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: Container(
                                                width: widthMultiplier * 30,
                                                height: widthMultiplier * 30,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                _pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: Container(
                                                width: widthMultiplier * 30,
                                                height: widthMultiplier * 30,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          _activeImageIndex == index
                                              ? Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children:
                                                          _buildPageIndicator(),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    double viewWidth = MediaQuery.of(context).size.width;
    List<Widget> indicators = [];
    for (int i = 0; i < _imageFiles.length; i++) {
      indicators.add(
        Container(
          width: ((viewWidth * 0.7) / _imageFiles.length) -
              (10 / _imageFiles.length) -
              10.0,
          height: 3.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: _activeImageIndex == i ? CustomTheme.appColor : Colors.black,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
    return indicators;
  }
}
