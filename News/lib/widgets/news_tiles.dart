import 'package:daily_news/screens/web_screen.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsTiles extends StatelessWidget {
  const NewsTiles(
    this._newsData,
    this._onRefresh,
    this._controller,
  );
  final _controller;
  final _newsData;
  final _onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: Radius.circular(15),
      thickness: 2,
      child: SmartRefresher(
        controller: _controller,
        enablePullDown: true,
        header: ClassicHeader(),
        onRefresh: _onRefresh,
        child: ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _newsData['articles'].length,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                Container(
                  child: ListTile(
                    trailing: CachedNetworkImage(
                      imageUrl: _newsData['articles'][i]['urlToImage'] == null
                          ? 'https://images.unsplash.com/photo-1529243856184-fd5465488984?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=769&q=80'
                          : _newsData['articles'][i]['urlToImage'],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.25,
                      placeholderFadeInDuration: Duration(seconds: 2),
                      errorWidget: (bctx, s, _) => Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      placeholder: (bctx, _) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(_newsData['articles'][i]['title']),
                    ),
                    subtitle: _newsData['articles'][i]['description'] == null
                        ? Text('')
                        : Text(
                            _newsData['articles'][i]['description'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            WebScreen(_newsData['articles'][i]['url']),
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 20,
                  color: Colors.white30,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
