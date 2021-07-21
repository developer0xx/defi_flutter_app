import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_images.dart';

class CrowdsaleBackground extends StatelessWidget {
  final String imgUrl;

  const CrowdsaleBackground({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'crowdsale_background',
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 3,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imgUrl,
        ),
      ),
    );
  }
}
