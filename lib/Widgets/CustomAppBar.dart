
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final bool onBackEnable;

  const CustomAppBar({super.key, required this.title, required this.context, required this.onBackEnable});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Theme.of(context).primaryColor,
      ),
      height: MediaQuery.of(context).size.height / 3,
      child: Stack(
        children: [
          if(onBackEnable)
            Positioned(
              left: 10,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0,),
                onPressed: ()=>Navigator.pop(context),
              ),
            ) else
            Positioned(
              left: 10,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 40.0,),
                onPressed: ()=> Scaffold.of(context).openDrawer())
                ,
              ),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQuery.of(context).size.height / 3);
}
