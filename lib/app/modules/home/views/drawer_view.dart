import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_first_app/app/modules/best_seller_detail/views/best_seller_detail_view.dart';
import 'package:my_first_app/app/modules/sales/views/sales_view.dart';

class DrawerView extends GetView {
  const DrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.currency_exchange,
              text: 'Sales',
              onTap: () => Get.to(() =>SalesView(), transition: Transition.cupertino)), 
          _drawerItem(
              icon: Icons.group,
              text: 'Best Seller Detail',
              onTap: () => Get.to(() =>  BestSellerDetailView(), transition: Transition.cupertino)), 
          _drawerItem(
              icon: Icons.access_time,
              text: 'Recent',
              onTap: () => print('Tap Recent menu')),
          _drawerItem(
              icon: Icons.delete,
              text: 'Trash',
              onTap: () => print('Tap Trash menu')),
          const Divider(height: 25, thickness: 1),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text("Labels",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
          ),
          _drawerItem(
              icon: Icons.bookmark,
              text: 'Family',
              onTap: () => print('Tap Family menu'),),
        ],
      ),
    );
  }
}


Widget _drawerHeader() {
  return const UserAccountsDrawerHeader(
    currentAccountPicture: ClipOval(
      child: CircleAvatar(backgroundColor: Colors.yellowAccent, radius: 40,),
    ),
    otherAccountsPictures: [
      ClipOval(
        child: CircleAvatar(backgroundColor: Colors.redAccent, radius: 20,),
      ),
      ClipOval(
        child: CircleAvatar(backgroundColor: Colors.black12, radius: 20,),
      )
    ],
    accountName: Text('Belajar Flutter'),
    accountEmail: Text('hallo@belajarflutter.com'),
  );
}
Widget _drawerItem({IconData? icon, String? text, GestureTapCallback? onTap, }) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            text!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap!,
  );
}