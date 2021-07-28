import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget buildSidebarTitle(BuildContext context, String text, String route) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(15),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
              fontFamily: 'RobotoCondensed', fontSize: 22, color: Colors.white),
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(route);
        },
      ),
    );
  }

  Widget buildSidebarTitleRate(
      BuildContext context, String text, String route) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(15),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
              fontFamily: 'RobotoCondensed', fontSize: 22, color: Colors.white),
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/rateapp');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(30, 40, 10, 10),
              color: Colors.black,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.woolha.com/media/2020/03/eevee.png'),
                    minRadius: 50,
                    maxRadius: 75,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Anita",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '8369857456',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildSidebarTitle(context, "Profile ", '/'),
            buildSidebarTitle(context, "Questions ", '/'),
            buildSidebarTitle(context, "Favorites", '/'),
            buildSidebarTitle(context, "Settings", '/'),
            buildSidebarTitle(context, "Terms", '/'),
            buildSidebarTitleRate(context, "Rate App", '/rateapp'),
          ],
        ),
      ),
    );
  }
}
