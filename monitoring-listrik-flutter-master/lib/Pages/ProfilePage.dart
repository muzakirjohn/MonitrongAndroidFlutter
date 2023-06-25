import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:monitoring/Pages/LoginPage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 200.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.teal.shade400,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: Image.network(
                      "https://upload.wikimedia.org/wikipedia/id/a/a3/Logo_UIN_Syarif_Hidayatullah_Jakarta.png")
                  .image,
            ),
          ),
          const SizedBox(
            height: 12.0,
            width: 150,
          ),
          const Text(
            'UIN Listrik',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 12.0,
            width: 150,
          ),
          Text(
            'Administrator'.toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'SourceSansPro',
              color: Colors.teal.shade400,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 150,
            child: Divider(
              color: Colors.teal.shade400,
            ),
          ),
          InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        color: Colors.teal.shade900),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              }),
        ],
      ),
    );
  }
}
