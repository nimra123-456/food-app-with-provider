
import 'package:flutter/material.dart';

import 'package:fod_delievery_app/colors.dart';
import 'package:fod_delievery_app/pages/cart/cart_page.dart';



import 'main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  late  PersistentTabController _controller;
//   @override
//   void initState() {
// _controller = PersistentTabController(initialIndex: 0);

//     super.initState();
//   }

  
  int _selectedIndex = 0;
  List pages = [
    const MainFoodPage(),
    Container(child:const Center(child: Text("2nd page"))),
    const Cartpage(),
    Container(child: const Center(child: Text("4th page")))

  ];
  void onTapNav(int index){
setState(() {
  _selectedIndex= index;
  
});  }
// List<Widget> _buildScreens() {
//         return [
//        MainFoodPage(),
//     Container(child:Center(child: Text("2nd page"))),
//     Cartpage(),
//     Container(child:Center(child: Text("4th page")))
//         ];
//     }
    // List<PersistentBottomNavBarItem> _navBarsItems() {
    //     return [
    //         PersistentBottomNavBarItem(
    //             icon: Icon(CupertinoIcons.home),
    //             title: ("Home"),
    //             activeColorPrimary: CupertinoColors.activeBlue,
    //             inactiveColorPrimary: CupertinoColors.systemGrey,
    //         ),
    //         PersistentBottomNavBarItem(
    //             icon: Icon(CupertinoIcons.archivebox_fill),
    //             title: ("Archive"),
    //             activeColorPrimary: CupertinoColors.activeBlue,
    //             inactiveColorPrimary: CupertinoColors.systemGrey,
    //         ),
    //             PersistentBottomNavBarItem(
    //             icon: Icon(CupertinoIcons.cart_fill),
    //             title: ("Cart"),
    //             activeColorPrimary: CupertinoColors.activeBlue,
    //             inactiveColorPrimary: CupertinoColors.systemGrey,
    //         ),
    //         PersistentBottomNavBarItem(
    //             icon: Icon(CupertinoIcons.person),
    //             title: ("me"),
    //             activeColorPrimary: CupertinoColors.activeBlue,
    //             inactiveColorPrimary: CupertinoColors.systemGrey,
    //         ),
    //     ];
    // }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:pages[_selectedIndex],
      bottomNavigationBar:BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor:Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap:onTapNav,
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label:"Home"
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.archive),
          label:"History"
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label:"Cart"
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label:"me"
          ),
      ]) ,

    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //       context,
  //       controller: _controller,
  //       screens: _buildScreens(),
  //       items: _navBarsItems(),
  //       confineInSafeArea: true,
  //       backgroundColor: Colors.white, // Default is Colors.white.
  //       handleAndroidBackButtonPress: true, // Default is true.
  //       resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //       stateManagement: true, // Default is true.
  //       hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //       decoration: NavBarDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         colorBehindNavBar: Colors.white,
  //       ),
  //       popAllScreensOnTapOfSelectedTab: true,
  //       popActionScreens: PopActionScreensType.all,
  //       itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
  //         duration: Duration(milliseconds: 200),
  //         curve: Curves.ease,
  //       ),
  //       screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
  //         animateTabTransition: true,
  //         curve: Curves.ease,
  //         duration: Duration(milliseconds: 200),
  //       ),
  //       navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
  //   );
  // }
}