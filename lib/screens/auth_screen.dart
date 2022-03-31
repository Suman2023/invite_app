import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invite_app/providers/invite_state_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color(0XFF14C08D),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Please provide your number",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0XFFF2F2F2)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: phoneNumberField(height, width),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "We will send an OTP to verify this number",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF4F4F4F)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: phoneValidator(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * .35,
                  child: const Divider(color: Color(0XFF4F4F4F)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "OR",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF828282)),
                  ),
                ),
                SizedBox(
                  width: width * .35,
                  child: const Divider(color: Color(0XFF4F4F4F)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: googleLoginWidget(height, width),
          )
        ],
      ),
    );
  }

  Widget googleLoginWidget(double height, double width) {
    return borderSet(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FaIcon(
              FontAwesomeIcons.google,
              color: Color.fromARGB(255, 0, 170, 255),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Continue with Google",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFFF2F2F2)),
            ),
          ],
        ),
      ),
    );
  }

  Consumer phoneValidator() {
    return Consumer(builder: (context, ref, child) {
      final _phoneNumberState = ref.watch(phoneTextStateProvider.state);
      return continueButton(
          textSize: 18,
          onPressed: () {
            if (_phoneNumberState.state.text.length < 10) {
              defaultFlushbar(
                      message: "Invalid Phone Number",
                      color: const Color(0xFFEB5757))
                  .show(context);
            } else {
              defaultFlushbar(
                      message: "OTP sent",
                      color: const Color.fromARGB(255, 72, 245, 3))
                  .show(context);
            }
          });
    });
  }

  Flushbar<dynamic> defaultFlushbar(
      {required String message, required Color color}) {
    return Flushbar(
        messageText: Text(
          message,
          style: const TextStyle(
              color: Color(0XffF2F2F2),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: color);
  }

  Widget phoneNumberField(double height, double width) {
    return borderSet(
      height: height,
      width: width,
      child: Consumer(builder: (context, ref, child) {
        final _phoneController = ref.watch(phoneTextStateProvider.state);
        final _countryCodeState = ref.watch(countryCodeTextStateProvider.state);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: _countryCodeState.state,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFFF2F2F2)),
                    focusColor: Colors.white,
                    dropdownColor: Colors.blueGrey,
                    alignment: AlignmentDirectional.centerEnd,
                    iconEnabledColor: const Color(0XFFF2F2F2),
                    items: const [
                      DropdownMenuItem(
                        child: Text("+91"),
                        value: "+91",
                      ),
                      DropdownMenuItem(
                        child: Text("+1"),
                        value: "+1",
                      ),
                    ],
                    onChanged: (String? newVal) {
                      _countryCodeState.state = newVal!;
                    }),
              ),
              Flexible(
                child: TextFormField(
                  controller: _phoneController.state,
                  onChanged: (val) {},
                  maxLength: 10,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Add Phone Number",
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF9D9A9A)),
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFF2F2F2)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget borderSet(
      {required Widget child, required double height, required double width}) {
    return Center(
      child: Container(
          width: width * .80,
          // height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0Xff14c08d), width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: child),
    );
  }

  Widget continueButton(
      {required Function() onPressed, required double textSize}) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
        backgroundColor: MaterialStateProperty.all(
          const Color(0Xff14c08d),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "Continue",
          style: TextStyle(
              fontSize: textSize,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
