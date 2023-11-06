import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageButtons extends StatelessWidget {
  final Future<void> Function() onPressedOne;
  final Future<void> Function() onPressedTwo;
  final Future<void> Function() onPressedThree;

  const HomePageButtons({
    Key? key,
    required this.onPressedOne,
    required this.onPressedTwo,
    required this.onPressedThree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 20)),
              backgroundColor: MaterialStateProperty.all(
                Colors.teal[600],
              ),
            ),
            onPressed: onPressedOne,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications,color: Colors.white,size: 30,),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'Send Simple Notification',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 20)),
              backgroundColor: MaterialStateProperty.all(
                Colors.teal[600],
              ),
            ),
            onPressed: onPressedTwo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/schedule.png',
                  color: Colors.white,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 2,
                ),
                const Text(
                  'Send Schedule Notification',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 20)),
              backgroundColor: MaterialStateProperty.all(
                Colors.teal[600],
              ),
            ),
            onPressed: onPressedThree,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidCircleXmark,
                  size: 20,
                  color: Colors.teal[50],
                ),
                const SizedBox(
                  width: 2,
                ),
                const Text(
                  'Cancel Scheduled Notifications',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
