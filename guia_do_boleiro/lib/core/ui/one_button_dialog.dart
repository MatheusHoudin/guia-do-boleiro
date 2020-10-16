import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';

class OneButtonDialog extends StatelessWidget {
  final String image, title, message, okText;
  Function okFunction = () => Get.back();

  OneButtonDialog({this.title, this.message, this.okText = ok, this.image, this.okFunction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: DialogContentContainer(),
    );
  }

  Widget DialogContentContainer() {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        Content(),
        Positioned(
          top: -Consts.avatarRadius,
          child: Image(),
        )
      ],
    );
  }

  Widget Image() {
    return CircleAvatar(
      radius: Consts.avatarRadius,
      child: SvgPicture.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget Content() {
    return Container(
      padding: EdgeInsets.only(
        top: Consts.avatarRadius + 10,
        left: Consts.padding,
        right: Consts.padding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.firaSans(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
          Text(
            message,
            textAlign: TextAlign.justify,
            style: GoogleFonts.firaSans(
              fontSize: 16
            ),
          ),
          FlatButton(

            child: Text(
              okText,
              style: GoogleFonts.firaSans(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () => okFunction(),
          )
        ],
      ),
    );
  }
}

class Consts {
  static const double padding = 16.0;
  static const double avatarRadius = 40.0;
}
