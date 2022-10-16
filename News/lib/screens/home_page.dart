import 'package:daily_news/controller/news_api.dart';
import 'package:daily_news/widgets/main_drawer.dart';
import 'package:daily_news/widgets/news_tiles.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _sports = false,
      _business = false,
      _science = false,
      _gaming = false,
      _political = false,
      _coding = false;
  final _connectivity = Connectivity();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  checkInternetConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result.index;
  }

  onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    _refreshController.refreshCompleted();
  }

  selectedNews(category) {
    if (category == "Sports") {
      _sports = true;
      _science = false;
      _business = false;
      _gaming = false;
      _political = false;
      _coding = false;
    } else if (category == "Top Headlines") {
      _sports = false;
      _business = false;
      _science = false;
      _gaming = false;
      _political = false;
      _coding = false;
    } else if (category == "Business") {
      _business = true;
      _science = false;
      _sports = false;
      _gaming = false;
      _political = false;
      _coding = false;
    } else if (category == "Science") {
      _science = true;
      _business = false;
      _sports = false;
      _gaming = false;
      _political = false;
      _coding = false;
    } else if (category == "Gaming") {
      _science = false;
      _business = false;
      _sports = false;
      _gaming = true;
      _political = false;
      _coding = false;
    } else if (category == 'Political (India)') {
      _political = true;
      _science = false;
      _business = false;
      _sports = false;
      _gaming = false;
      _coding = false;
    } else if (category == 'Coding & Programming') {
      _political = false;
      _science = false;
      _business = false;
      _sports = false;
      _gaming = false;
      _coding = true;
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DailyNews',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        elevation: 0,
      ),
      drawer: MainDrawer(selectedNews),
      body: FutureBuilder(
          future: checkInternetConnectivity(),
          builder: (ctx, snap) {
            if (ConnectionState.waiting == snap.connectionState) {
              return Text('');
            }
            if (snap.data == ConnectivityResult.none.index) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Opps...No Internet Connection.',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.refresh_rounded,
                        size: 40,
                        semanticLabel: 'Refresh',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }
            return FutureBuilder(
              future: _coding
                  ? NewsApi.fetchProgrammingNews()
                  : _political
                      ? NewsApi.fetchPoliticalNews()
                      : _gaming
                          ? NewsApi.fetchGamingNews()
                          : _science
                              ? NewsApi.fetchScieneNews()
                              : _business
                                  ? NewsApi.fetchBusinessNews()
                                  : _sports
                                      ? NewsApi.fetchSportsNews()
                                      : NewsApi.fetchNewsTopHeadLines(),
              builder: (ctx, s) {
                if (s.connectionState == ConnectionState.waiting ||
                    !s.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final Map<String, dynamic> data =
                    s.data as Map<String, dynamic>;
                return NewsTiles(data, onRefresh, _refreshController);
              },
            );
          }),
    );
  }
}
