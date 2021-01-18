import 'package:bottiter/core/store/home_store.dart';
import 'package:bottiter/core/viewmodel/home_viewmodel.dart';
import 'package:bottiter/ui/page/new_post_page.dart';
import 'package:bottiter/ui/view/home_view.dart';
import 'package:bottiter/ui/view/news_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarPage extends StatefulWidget {
  BottomNavigationBarPage({Key key}) : super(key: key);

  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage>
    with SingleTickerProviderStateMixin<BottomNavigationBarPage> {
  int _selectedIndex = 0;

  HomeView home = HomeView();
  NewsListView news = NewsListView();

  @override
  void dispose() {
    home = null;
    news = null;
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _body() {
    return SafeArea(child: _selectedIndex == 0 ? home : news);
  }

  _onFloatingActionButtonPressed() {

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return NewPostPage();
    })).then((_) {
      Provider.of<HomeViewModel>(context).fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _body(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _onFloatingActionButtonPressed,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'News',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            _selectedIndex == 0 ? Colors.deepOrange : Colors.lightGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}
