import 'package:flutter/cupertino.dart';
import 'package:shop/layout/main_cubit.dart';

Text textstyle({
  required context,
  required String arabicText,
  required String englishText,
  required double fontsize,
  required TextAlign TextAlign,
  required Color color,
  int maxline = 1,
}) {
  return Text(
    main_cubit.get(context).isArabic ? arabicText : englishText,
    maxLines: maxline,
    overflow: TextOverflow.ellipsis,
    textDirection: main_cubit.get(context).isArabic
        ? TextDirection.rtl
        : TextDirection.ltr,
    textAlign: TextAlign,
    style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontFamily: 'NotoNaskhArabic-Bold',
        fontWeight: FontWeight.bold),
  );
}
