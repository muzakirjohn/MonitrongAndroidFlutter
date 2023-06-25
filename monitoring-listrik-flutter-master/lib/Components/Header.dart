import 'package:flutter/material.dart';
import 'package:monitoring/widgets/Headline.dart';

class MyHeaderPage extends StatefulWidget {
  final String title;
  const MyHeaderPage({Key? key, this.title = 'dashboard'}) : super(key: key);

  @override
  State<MyHeaderPage> createState() => _MyHeaderPageState();
}

class _MyHeaderPageState extends State<MyHeaderPage> {
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: const Headline(
            title: 'Dashboard',
            caption: 'Cette card est faite pour ',
          ),
        ),
        // new GestureDetector(
        //   onTap: () => {
        //     print("object"),
        //   },
        //   child: Container(
        //     width: 45,
        //     height: 45,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50),
        //       color: Colors.transparent,
        //       border: Border.all(
        //         color: Colors.black,
        //         width: 1,
        //       ),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(5.0),
        //       child: Image.network(
        //           "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/User_icon-cp.svg/1200px-User_icon-cp.svg.png"),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
