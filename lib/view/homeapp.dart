import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'sessao_livros.dart';
import 'custom_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreenApp extends StatefulWidget {
  const HomeScreenApp({Key? key}) : super(key: key);

  @override
  State<HomeScreenApp> createState() => _HomeScreenAppState();
}

class _HomeScreenAppState extends State<HomeScreenApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<void> deslogarFirebase() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_hadleTabSection);
    super.initState();
  }

  _hadleTabSection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Troca Livros'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.search),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 260,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Livro_1')],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Livro_2')],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Livro_3')],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Livro_4')],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                automaticIndicatorColorAdjustment: true,
                indicatorColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                labelPadding: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.only(left: 10),
                tabs: [
                  Tab(
                    child: Text("Todos",
                        style: TextStyle(
                            color: _tabController.index == 0
                                ? Colors.white
                                : Colors.black)),
                  ),
                  Tab(
                    child: Text("Romance",
                        style: TextStyle(
                            color: _tabController.index == 1
                                ? Colors.white
                                : Colors.black)),
                  ),
                  Tab(
                    child: Text("Drama",
                        style: TextStyle(
                            color: _tabController.index == 2
                                ? Colors.white
                                : Colors.black)),
                  ),
                  Tab(
                    child: Text("Didáticos",
                        style: TextStyle(
                            color: _tabController.index == 3
                                ? Colors.white
                                : Colors.black)),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: [
              SessaoLivros(),
              Container(),
              Container(),
              Container(),
              Container(),
            ][_tabController.index],
          )
        ],
      ),
    );
  }
}
