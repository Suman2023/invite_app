import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invite_app/providers/invite_state_provider.dart';

class RoundedGreenBorder extends StatelessWidget {
  const RoundedGreenBorder({Key? key}) : super(key: key);

  // double height, width;
  // Widget child;
  // RoundedGreenBorder(
  //     {Key? key,
  //     required this.height,
  //     required this.width,
  //     required this.child})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: width * .80,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0Xff14c08d), width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Consumer(builder: (context, ref, child) {
            final _inviteController = ref.watch(inviteTextStateProvider.state);
            return TextFormField(
              controller: _inviteController.state,
              onChanged: (val) {},
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              maxLength: 5,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                hintText: "Add Invite Code",
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF9D9A9A)),
                border: InputBorder.none,
                counterText: "",
              ),
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFFF2F2F2)),
            );
          }),
        ),
      ),
    );
  }
}
