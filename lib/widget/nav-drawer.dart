import 'package:flutter/material.dart';
import 'package:obsolette/constants/color.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_session/flutter_session.dart';
import 'package:obsolette/ui/favourite/favourite_screen.dart';
import 'package:obsolette/ui/search/search_screen.dart';
import 'package:obsolette/ui/login/login_screen.dart';
import 'package:obsolette/constants/string.dart';
import 'package:obsolette/api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavDrawerWidget extends StatefulWidget {
  final int? lang;
  NavDrawerWidget({Key? key, this.lang}) : super(key: key);

  @override
  _NavDrawerWidgetState createState() => _NavDrawerWidgetState();
}

class _NavDrawerWidgetState extends State<NavDrawerWidget> {
  String? email;
  int language = 0;
  List languageArr = ["fr", "de", "en"];
  Service _service = new Service();
  getEmail() async {
    String? value = await FlutterSession().get("email");
    setState(() {
      email = value;
    });
  }

  @override
  void initState() {
    language = widget.lang!;
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/user.png',
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    (email != null) ? email! : '',
                    style: TextStyle(color: themeColor, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    languageId: 0,
                  ),
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('Favourite'),
            onTap: () => {
              if (email == null)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  )
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteScreen(),
                    ),
                  )
                }
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: (email != null) ? Text('Logout') : Text('Login'),
            onTap: () async => {
              if (email == null)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  )
                }
              else
                {
                  await FlutterSession().set("email", ''),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  )
                }
            },
          ),
          (email != null)
              ? ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Delete My Account',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onTap: () async => {
                    showDialog(
                      context: context,
                      builder: (context) {
                        // return AlertDialog(
                        //   title: Text("AlertDialog"),
                        //   content: Text(
                        //       "Would you like to continue learning how to use Flutter alerts?"),
                        //   actions: [
                        //     cancelButton,
                        //     continueButton,
                        //   ],
                        // );
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 16,
                          child: Container(
                            height: 170,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    multiLanguage[languageArr[language]]![
                                        "delete_popup_title"]!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: themeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    multiLanguage[languageArr[language]]![
                                        "delete_popup_note"]!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  MaterialButton(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 30, 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      multiLanguage[languageArr[language]]![
                                          "delete_popup_button"]!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: themeColor,
                                    onPressed: () async {
                                      String response =
                                          await _service.closeAccount();
                                      if (response == "success") {
                                        await FlutterSession().set("email", '');
                                        Fluttertoast.showToast(
                                            msg: "Successfully Deleted",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: successColor,
                                            textColor: Colors.white,
                                            timeInSecForIosWeb: 1);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  },
                )
              : Text('')
        ],
      ),
    );
  }
}

Widget cancelButton = TextButton(
  child: Text("Cancel"),
  onPressed: () {},
);
Widget continueButton = TextButton(
  child: Text("Continue"),
  onPressed: () {},
);
