import 'package:flutter/material.dart';
import 'package:obsolette/api/api.dart';
import 'package:obsolette/constants/color.dart';
import 'package:obsolette/constants/string.dart';
import 'package:obsolette/ui/dialog/dialog_screen.dart';
import 'package:obsolette/widget/kLoadingWidget.dart';
import 'package:obsolette/ui/index/index_screen.dart';
import 'package:obsolette/widget/languageBarWidget.dart';
import 'package:obsolette/widget/nav-drawer.dart';

class ExperienceScreen extends StatefulWidget {
  @override
  ExperienceScreenState createState() => ExperienceScreenState();
  final int? languageId;
  ExperienceScreen({Key? key, this.languageId}) : super(key: key);
}

class ExperienceScreenState extends State<ExperienceScreen> {
  Service _service = new Service();
  Map<String, dynamic> dialogues = {};
  int language = 0;
  int isFavPage = 0;
  List languageArr = ["fr", "de", "en"];
  String dropdownvalue = '';
  List<String> sorts = [];
  Future<Map<String, dynamic>> loadingData() async {
    dialogues = await _service.getExperience(language);
    print(dialogues["result"][1]);
    return dialogues;
  }

  @override
  void initState() {
    language = widget.languageId!;
    sorts =
        List<String>.from(multiLanguage[languageArr[language]]!["exp_sort"]!);
    dropdownvalue = sorts[0];
    super.initState();
  }

  Widget ExperienceWidget(context) {
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
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: sorts.length,
                    itemBuilder: (BuildContext context, int index) {
                      String title = sorts.elementAt(index);
                      List<dynamic> values =
                          dialogues["result"].elementAt(index);
                      return Card(
                        color: themeLightColor,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text(
                              title,
                              style: TextStyle(
                                  color: themeDarkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                                children: values
                                    .map(
                                      (i) => new GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => StoryScreen(
                                          //         keyword: i["a"],
                                          //         language: language),
                                          //   ),
                                          // );
                                        },
                                        child: Text(
                                          i["titre"],
                                          style: TextStyle(
                                              color: btnColor, fontSize: 20),
                                        ),
                                      ),
                                    )
                                    .toList()),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    });
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ExperienceScreen(languageId: languageId),
                    ),
                  );
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
                            multiLanguage[languageArr[language]]!["exp_title"]!,
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
                        "assets/images/obsolette_neurone.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            child: ExperienceWidget(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //   padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                  //   child: Container(
                  //     child: Column(
                  //       children: [
                  //         DropdownButton<String>(
                  //           icon: const Icon(
                  //             Icons.keyboard_arrow_down,
                  //             color: Colors.black,
                  //           ),
                  //           value: dropdownvalue,
                  //           underline: Container(
                  //             height: 2,
                  //             color: Colors.black,
                  //           ),
                  //           items: sorts.map((String value) {
                  //             return DropdownMenuItem<String>(
                  //               value: value,
                  //               child: Text(
                  //                 value,
                  //               ),
                  //             );
                  //           }).toList(),
                  //           onChanged: (String? newValue) {
                  //             setState(() {
                  //               dropdownvalue = newValue!;
                  //             });
                  //           },
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
