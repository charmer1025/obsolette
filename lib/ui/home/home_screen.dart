import 'package:flutter/material.dart';
import 'package:obsolette/constants/color.dart';
import 'package:obsolette/ui/search/search_screen.dart';
import 'package:obsolette/ui/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
          ),
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.2,
              ),
              Center(
                child: Container(
                  width: mq.width * 0.5,
                  child: Image.asset(
                    'assets/images/obsolette_logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * 0.05,
              ),
              Center(
                child: Container(
                  width: mq.width * 0.5,
                  child: Image.asset(
                    'assets/images/chercheuse.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                      builder: (context) => SearchScreen(
                        languageId: 0,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: mq.width * 0.6,
                  child: Center(
                    child: Text(
                      "Let's Go!",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
