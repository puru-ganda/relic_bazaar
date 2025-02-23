import 'package:flutter/material.dart';
import 'package:retro_shopping/helpers/constants.dart';
import 'package:retro_shopping/services/auth_service.dart';
import '../widgets/drawer_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerWidget extends StatefulWidget {
  final PageController pageController;
  const DrawerWidget({
    this.pageController,
    Key key,
  }) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthenticationService _authenticationService = AuthenticationService();

  void goToScreen(int index) {
    if (widget.pageController.initialPage == index) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        widget.pageController.jumpToPage(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: <Widget>[
          DrawerItem(
              icon: Icons.person,
              title: 'ABOUT',
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteConstant.ABOUT_SCREEN,
                );
              }),
          DrawerItem(
            icon: Icons.shopping_cart,
            title: 'CART',
            onTap: () => goToScreen(2),
          ),
          DrawerItem(
            icon: Icons.inbox,
            title: 'ORDERS',
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteConstant.ORDERS_SCREEN,
              );
            },
          ),
          DrawerItem(
            icon: Icons.list,
            title: 'WISHLIST',
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteConstant.WISHLIST_SCREEN,
              );
            },
          ),
          DrawerItem(
            icon: Icons.category,
            title: 'PRODUCTS',
            onTap: () => goToScreen(0),
          ),
          DrawerItem(
            icon: Icons.logout,
            title: 'LOG OUT',
            onTap: () async {
              await _authenticationService.userSignOut(context);
              AuthenticationService.signOutGoogle().then(
                (void res) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteConstant.LOGIN_SCREEN,
                    (Route<dynamic> route) => false,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
