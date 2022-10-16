import 'package:daily_news/controller/authentication.dart';
import 'package:daily_news/screens/login_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer(this._selectedNews);
  final _selectedNews;

  buildListTile(title, context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onTap: () => _selectedNews(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Color(0xff2B2B2B),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 40),
                child: Text(
                  'Daily News',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Neuton',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildListTile('Top Headlines', context),
              buildListTile('Sports', context),
              buildListTile('Business', context),
              buildListTile('Science', context),
              buildListTile('Gaming', context),
              buildListTile('Political (India)', context),
              buildListTile('Coding & Programming', context),
              ListTile(
                  title: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  onTap: () async {
                    await AuthenticationService.signOut(context: context);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
