import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedPP extends StatelessWidget {
  final String imageUrl;
  final double size;

  const RoundedPP({super.key, required this.imageUrl, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: isUrl(imageUrl) ?
      ClipOval(
        child: SvgPicture.asset(
          imageUrl,
          semanticsLabel: 'Profile Picture',
          height: 150,
          width: 150,
        ),
      ): ClipOval(
        child: Image(image: NetworkImage(imageUrl),height: 150, width: 150, fit: BoxFit.fill,)
      ),
    );
  }

  bool isUrl(String imageUrl){
      Uri? uri = Uri.tryParse(imageUrl);
      if (uri == null) {
        return false;
      }
      return uri.hasScheme && uri.hasAuthority;
    }
}

