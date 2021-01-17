import 'package:bottiter/ui/view/bot_sliver_app_bar.dart';
import 'package:bottiter/ui/view/home_view.dart';
import 'package:bottiter/ui/view/news_list_view.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarPage extends StatefulWidget {
  BottomNavigationBarPage({Key key}) : super(key: key);

  @override
  _BottomNavigationBarPageState createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> with SingleTickerProviderStateMixin<BottomNavigationBarPage>{
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _body() {
    return SafeArea(
      child: NewsListView()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
        child: Icon(Icons.add),
      ) : null,
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
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
