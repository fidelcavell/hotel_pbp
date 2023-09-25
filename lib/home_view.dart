import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    // home page
    _HomePage(),
    
    // profile page
    _ProfilePage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFC5F86),
        selectedItemColor: Colors.white, 
      selectedLabelStyle: TextStyle(color: Colors.white),
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFF0F5),
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Image.asset('./lib/images/hotel1.jpg'),
            )
          );
        }),
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFC5F86),
          title: const Text('Choose Profile'),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                text: 'Thessa',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'Jean',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'Bayu',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'Fidel',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'Geraldi',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'Fadhel',
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            NestedTabBar('Thessalonica Angelina', '210711122', './images/yori.jpg'),
            NestedTabBar('Jean Alexander', '210711427', './images/jeha.png'),
            NestedTabBar('Abraham Bayudestar', '210711447', './images/Dena.jpg'),
            NestedTabBar('Geraldi Jamin', '210711293', './images/budi.png'),
            NestedTabBar('Fadhel Sitakka', '210711183', './images/Kevin.jpg'),
          ],
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.fullname, this.npm, this.url, {super.key});

  final String fullname;
  final String npm;
  final String url;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Card(
                color: Color(0xFFFC5F86),
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.url),
                      radius: 68.0, 
                    ),

                    SizedBox(height: 20.0),

                    Text(
                      widget.fullname,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0, 
                      ),
                    ),

                    Text(
                      widget.npm,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),

                    // Add spacing
                    SizedBox(height: 20.0),

                    // Add any additional content here (e.g., tabs)
                    // ...

                    // Add the TabBar and TabBarView here
                  ],
                ),
              ),
            ],
          ),
        ),
],
);
}
}