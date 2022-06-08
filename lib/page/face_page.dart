import 'package:auth_finger/api/local_auth_api.dart';
import 'package:auth_finger/api/local_auth_api.dart';
import 'package:auth_finger/main.dart';
import 'package:auth_finger/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FacePage extends StatelessWidget { 
  bool isAuthenticated = false; 
  @override
  Widget build(BuildContext context) => Scaffold( 
        appBar: AppBar( 
          title: Text(MyApp.title), 
          centerTitle: true, 
          backgroundColor: Colors.blue,
        ), 
        body: Padding( 
          padding: EdgeInsets.all(32), 
          child: Center( 
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //!######################################## F I N G E R
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.fingerprint, size: 26),
                  label: Text(
                    "Scan Finger",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    isAuthenticated = await LocalAuthApi.authenticateFinger();

                    try {
                      if (isAuthenticated ==true) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    } on PlatformException catch (e) {
                      return false;
                    }
                  },
                ),
                SizedBox(height: 24),
                //!########################################## mf F A C E
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.face, size: 26),
                  label: Text(
                    "Face",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    final isAuthenticatedFace =
                        await LocalAuthApi.authenticateFace();

                    if (isAuthenticatedFace == true) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      print("Active face");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );

  

  Widget buildButton({
    @required String text,
    @required IconData icon,
    @required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );

 
}
