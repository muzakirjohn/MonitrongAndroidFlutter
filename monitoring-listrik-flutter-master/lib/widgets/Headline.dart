import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Headline extends StatelessWidget {
  final String title;
  final String? caption;

  const Headline({
    Key? key,
    required this.title,
    this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontStyle: GoogleFonts.poppins().fontStyle),
            ),
            caption != null
                ? Text(
                    caption!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontStyle: GoogleFonts.poppins().fontStyle),
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
