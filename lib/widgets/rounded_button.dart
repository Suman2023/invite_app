import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invite_app/firebase_helper/firestore_helper.dart';
import 'package:invite_app/providers/invite_state_provider.dart';
import 'package:invite_app/screens/auth_screen.dart';

class RoundedGreenButton extends StatelessWidget {
  RoundedGreenButton({Key? key}) : super(key: key);
  final FirestoreHelper firestoreHelper = FirestoreHelper();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final inviteCode = ref.watch(inviteTextStateProvider.state);
      final buttonActive = ref.watch(continueBottonStateProvider.state);
      return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
          backgroundColor: MaterialStateProperty.all(
            buttonActive.state ? const Color(0Xff14c08d) : Colors.blueGrey,
          ),
        ),
        onPressed: buttonActive.state
            ? () async {
                FocusScope.of(context).unfocus();
                buttonActive.state = false;
                bool successful = await firestoreHelper
                    .checkInviteCodeValidity(inviteCode.state.text);
                inviteCode.state.clear();
                if (successful == false) {
                  buttonActive.state = true;
                  Flushbar(
                    messageText: const Text(
                      'Invalid code. Please try again',
                      style: TextStyle(
                          color: Color(0XffF2F2F2),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 3),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: const Color(0xFFEB5757),
                  ).show(context);
                } else if (successful == true) {
                  buttonActive.state = true;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AuthScreen()));
                }
              }
            : null,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Continue",
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
    });
  }
}
