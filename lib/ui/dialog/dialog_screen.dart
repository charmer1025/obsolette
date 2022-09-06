import 'package:flutter/material.dart';
import 'package:obsolette/api/api.dart';
import 'package:obsolette/constants/color.dart';
import 'package:obsolette/constants/string.dart';
import 'package:obsolette/ui/index/index_screen.dart';
import 'package:obsolette/widget/kLoadingWidget.dart';
import 'package:obsolette/widget/languageBarWidget.dart';
import 'package:obsolette/widget/nav-drawer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_session/flutter_session.dart';
import 'package:obsolette/ui/login/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogScreen extends StatefulWidget {
  final String? storyNo;
  final int? language;

  DialogScreen({Key? key, this.storyNo, this.language}) : super(key: key);
  @override
  DialogScreenState createState() => DialogScreenState();
}

class DialogScreenState extends State<DialogScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController commentController = TextEditingController();
  Service _service = new Service();
  Map<String, dynamic> dialog = {};
  int language = 0;
  bool isFavourite = false;
  String? favouriteId;
  List languageArr = ["fr", "de", "en"];
  Future<Map<String, dynamic>> loadingData() async {
    setState(() {
      _isLoad = true;
    });
    dialog = await _service.getDialog(widget.storyNo, language);
    if (dialog["isFavourite"] == 1) {
      isFavourite = true;
      setState(() {
        favouriteId = dialog["favourite_id"];
      });
    }
    setState(() {
      _isLoad = false;
    });
    return dialog;
  }

  bool _isLoad = false;
  @override
  void initState() {
    language = widget.language!;
    super.initState();
    loadingData();
  }

  void showMessage(result, status) {
    if (status == "danger") {
      Fluttertoast.showToast(
          msg: result,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: dangerColor,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
    }
    if (status == "success") {
      Fluttertoast.showToast(
          msg: result,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: successColor,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
    }
  }

  Widget dialogWidget(context, mq) {
    return (_isLoad)
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  themeColor,
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kLoadingWidget(context),
                ],
              ),
            ),
          )
        : Stack(
            children: [
              body(),
              Positioned(
                right: 0,
                top: 20,
                child: heartButton(),
              ),
              Positioned(
                right: 0,
                bottom: 20,
                child: addCommentButton(),
              ),
            ],
          );
  }

  Widget body() {
    var mq = MediaQuery.of(context).size;
    return Container(
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
                        (dialog["titre"] != "")
                            ? dialog["titre"]
                            : multiLanguage[languageArr[language]]!["no_title"],
                        style: TextStyle(
                          fontSize: 22,
                          color: textColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        (dialog["chapeau"] != "")
                            ? dialog["chapeau"]
                            : multiLanguage[languageArr[language]]!["no_hat"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: mq.width * 0.2,
                  // height: 300,
                  margin: const EdgeInsets.only(left: 20.0, right: 0.0),
                  child: Image.network(
                    "https://obsolette.com/images/humeurs/" +
                        dialog["illustration"].toString() +
                        ".png",
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
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: (dialog["obsolettes"].length != 0 &&
                              dialog["doubles"].length != 0)
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: dialog["obsolettes"].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String _obsolette =
                                              dialog["obsolettes"]
                                                  .elementAt(index);
                                          String _double = dialog["doubles"]
                                              .elementAt(index);
                                          return Card(
                                            color: themeLightColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      _obsolette,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: textBlackColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      _double,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: textColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: dialog["comments"].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          dynamic comments = dialog["comments"]
                                              .elementAt(index);
                                          return Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 10, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.format_quote,
                                                        color: lightBlackColor,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 9,
                                                    child: Container(
                                                      width: double.maxFinite *
                                                          0.9,
                                                      child: Column(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              comments[
                                                                  "content"],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    textBlackColor,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              comments[
                                                                  "updated_at"],
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                                multiLanguage[languageArr[language]]![
                                    "no_dialog"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                      height: mq.height * 0.57,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget heartButton() {
    return MaterialButton(
      shape: CircleBorder(
        side: BorderSide(
          width: 2,
          color: Colors.white,
          style: BorderStyle.solid,
        ),
      ),
      child: Icon(
        isFavourite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      color: Colors.white,
      padding: EdgeInsets.all(10),
      onPressed: () async {
        String email = await FlutterSession().get("email");
        // ignore: unnecessary_null_comparison
        if (email == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } else {
          if (!isFavourite) {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 16,
                  child: Container(
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            multiLanguage[languageArr[language]]![
                                "favourite_popup_title"]!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              multiLanguage[languageArr[language]]![
                                  "favourite_popup_button"]!,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            color: themeColor,
                            onPressed: () async {
                              String id =
                                  await _service.setFavourite(widget.storyNo);

                              setState(() {
                                favouriteId = id;
                              });

                              Navigator.pop(context);
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            await _service.removeFavourite(favouriteId);
            setState(() {
              isFavourite = !isFavourite;
            });
          }
        }
      },
    );
  }

  Widget addCommentButton() {
    return MaterialButton(
      shape: CircleBorder(
        side: BorderSide(
          width: 2,
          color: Colors.white,
          style: BorderStyle.solid,
        ),
      ),
      child: Icon(
        Icons.comment_outlined,
        color: Colors.red,
      ),
      color: Colors.white,
      padding: EdgeInsets.all(10),
      onPressed: () async {
        String email = await FlutterSession().get("email");
        // ignore: unnecessary_null_comparison
        if (email == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 16,
                child: Container(
                  height: 240,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          multiLanguage[languageArr[language]]![
                              "add_comment_popup_title"]!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: commentController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            multiLanguage[languageArr[language]]![
                                "add_comment_popup_button"]!,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          color: themeColor,
                          onPressed: () async {
                            String result = "";
                            String status = "";
                            bool submit = true;
                            if (commentController.text == "") {
                              result = "Please enter comment text";
                              status = "danger";
                              showMessage(result, status);
                              submit = false;
                            }
                            if (submit) {
                              String response = await _service.addComment(
                                  widget.storyNo,
                                  commentController.text,
                                  language);
                              if (response == "success") {
                                result =
                                    "Successfully submitted\nThis will be hidden until approved";
                                status = "success";
                                showMessage(result, status);
                                Navigator.pop(context);
                                // loadingData();
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavDrawerWidget(lang: language),
      appBar: new AppBar(
        backgroundColor: themeColor,
        // leading: new IconButton(
        //   icon: new Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        actions: <Widget>[
          LanguageBarWidget(
              lang: language,
              setLanguage: (int languageId) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndexScreen(languageId: languageId),
                  ),
                );
              }),
        ],
      ),
      body: Center(child: dialogWidget(context, mq)),
    );
  }
}
