import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
       elevation: 30,
       child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 3 ,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.darken,
                  color: Theme.of(context).primaryColor,
                ),
                child:Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                      "assets/images/profile.svg",
                      semanticsLabel: 'Acme Logo',
                    height: 150,
                    width: 150,
                  ),

              ),
            ),),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
    );
  }
}
