import 'package:faceid_auth_example/api/local_auth_api.dart';
import 'package:faceid_auth_example/main.dart';
import 'package:faceid_auth_example/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FacePage extends StatelessWidget { 
  bool isAuthenticated = false; 
  @override
  Widget build(BuildContext context) => Scaffold( 
        appBar: AppBar( 
          title: Text(MyApp.title), 
          centerTitle: true, 
        ), 
        body: Padding( 
          padding: EdgeInsets.all(32), 
          child: Center( 
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildHeader(),
                SizedBox(height: 32),
                // buildAvailability(context),
                SizedBox(height: 24),
                // buildAuthenticate(context),
                //!######################################## F I N G E R
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.face, size: 26),
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

  Widget buildHeader() => Column(
        children: [
          Text(
            'Face ID Auth',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) {
              final colors = [Colors.blueAccent, Colors.pink];

              return RadialGradient(colors: colors).createShader(bounds);
            },
            child: Icon(Icons.face_retouching_natural,
                size: 100, color: Colors.white),
          ),
        ],
      );
}
