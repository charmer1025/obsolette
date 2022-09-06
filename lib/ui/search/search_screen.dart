import 'package:flutter/material.dart';
import 'package:obsolette/api/api.dart';
import 'package:obsolette/constants/color.dart';
import 'package:obsolette/constants/string.dart';
import 'package:obsolette/ui/dialog/dialog_screen.dart';
import 'package:obsolette/ui/experience/experience_screen.dart';
import 'package:obsolette/widget/kLoadingWidget.dart';
import 'package:obsolette/ui/index/index_screen.dart';
import 'package:obsolette/widget/languageBarWidget.dart';
import 'package:obsolette/widget/nav-drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
  final int? languageId;
  SearchScreen({Key? key, this.languageId}) : super(key: key);
}

class _SearchScreenState extends State<SearchScreen> {
  Service _service = new Service();
  Map<String, dynamic> items = {};
  int language = 0;
  int isFavPage = 0;
  List languageArr = ["fr", "de", "en"];
  Future<Map<String, dynamic>> loadingData() async {
    items = await _service.getSearch(language);
    return items;
  }

  @override
  void initState() {
    language = widget.languageId!;
    super.initState();
  }

  Widget SearchWidget(context) {
    var mq = MediaQuery.of(context).size;
    return FutureBuilder(
        future: loadingData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      kLoadingWidget(context),
                    ],
                  ),
                ),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError || snapshot.data == null) {
                return Container(
                  // color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        kLoadingWidget(context),
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 170.0,
                        viewportFraction: 1.0,
                      ),
                      items: items["result"].map<Widget>((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Container(
                                    // color: themeLightColor,
                                    width: mq.width,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          item["story"],
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        RaisedButton(
                                          color: themeColor,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DialogScreen(
                                                  storyNo: item["id"],
                                                  language: language,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            color: themeColor,
                                            height: 50,
                                            width: mq.width * 0.5,
                                            child: Center(
                                              child: Text(
                                                multiLanguage[languageArr[
                                                    language]]!["read_dialog"]!,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        );
                      }).toList(),
                    )),
                    SizedBox(
                      height: 80,
                    ),
                    RaisedButton(
                      color: themeColor,
                      // shape: new RoundedRectangleBorder(
                      //   borderRadius: new BorderRadius.circular(10.0),
                      // ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => LoginScreen(),
                            builder: (context) => IndexScreen(
                              languageId: language,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: mq.width * 0.75,
                        child: Center(
                          child: Text(
                            multiLanguage[languageArr[language]]![
                                "search_keyword_btn"]!,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: themeColor,
                      // shape: new RoundedRectangleBorder(
                      //   borderRadius: new BorderRadius.circular(10.0),
                      // ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => LoginScreen(),
                            builder: (context) => ExperienceScreen(
                              languageId: language,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: mq.width * 0.75,
                        child: Center(
                          child: Text(
                            multiLanguage[languageArr[language]]![
                                "search_experience_btn"]!,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavDrawerWidget(lang: language),
      appBar: new AppBar(
        backgroundColor: themeColor,
        actions: <Widget>[
          LanguageBarWidget(
              lang: language,
              setLanguage: (int languageId) {
                setState(() {
                  language = languageId;
                });
              }),
        ],
      ),
      body: Center(
        child: Container(
          color: themeLightColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 25, 12, 25),
                child: Row(
                  children: [
                    Container(
                      width: mq.width * 0.6,
                      child: Column(
                        children: [
                          Text(
                            multiLanguage[languageArr[language]]![
                                "search_title"]!,
                            style: TextStyle(
                              fontSize: 22,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mq.width * 0.27,
                      margin: const EdgeInsets.only(left: 20.0, right: 0.0),
                      child: Image.asset(
                        "assets/images/chercheuse.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        themeColor,
                        themeLightColor,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                      child: SearchWidget(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
