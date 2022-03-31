import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invite_app/widgets/rounded_button.dart';
import 'package:invite_app/widgets/rounded_green_border.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Continue with Invite Code",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0XFFFFFFFF)),
          ),
          const RoundedGreenBorder(),
          RoundedGreenButton(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "No invite code?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFF2F2F2)),
              ),
              const Text(
                'If you want an invite code and get early access,',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFFF2F2F2)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'please fill out ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFFE0E0E0),
                    ),
                  ),
                  Text(
                    'this form',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFFF2F2F2),
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    width: 0.1,
                  ),
                  FaIcon(
                    FontAwesomeIcons.shareFromSquare,
                    color: Color(0XFFF2F2F2),
                    size: 12,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
