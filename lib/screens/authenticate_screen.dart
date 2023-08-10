import 'dart:async';

import './faragir_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Auth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../widgets/elements/spinner.dart';

//--------------------------------------------------------------------------------------------------------------

class AuthenticateScreen extends StatefulWidget {
  // ---------------- feilds ------------------
  static const routeName = '/authenticate';

  const AuthenticateScreen({super.key});
  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  // ---------------- state ------------------
  OtpFieldController otpFieldController = OtpFieldController();
  var _isLoading = false;
  String mobileNumber = '';
  int? userId;
  int? otp_token;
  Timer? _timer;
  int _startSeconds = 90;
  int _elapsedSeconds = 0;
  // ---------------- lifecycle ------------------
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void didChangeDependencies() {
    // extract arguments
    final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      mobileNumber = userData['mobileNumber'];
      userId = userData['id'];
      otp_token = userData['otp_token'];
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  // ---------------- methods ------------------
  // remaining timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_startSeconds <= 0) {
          _timer!.cancel();
        } else {
          _startSeconds = _startSeconds - 1;
          _elapsedSeconds = _elapsedSeconds + 1;
        }
      });
    });
  }

  // enter root screen
  Future<void> _enterHandler() async {
    final Map<String, dynamic> userData = {'user_id': userId, 'otp_token': otp_token, 'req_otp_token': '11111'};
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).confirm(userData);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(FaragirScreen.routeName);
  }

  // ---------------- UI ------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final remainingDuration = Duration(seconds: _startSeconds);
    final remaining = '${remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Scaffold(
      body: _isLoading
          ? const Spinner()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Image.asset('assets/images/authentication.png', fit: BoxFit.fill, width: deviceSize.width - 30),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(child: Text('احراز هویت', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text.rich(
                      TextSpan(text: ' ما یک پیامک حاوی کد تایید برای شماره ', style: TextStyle(fontSize: 17, color: Colors.grey.shade700), children: <TextSpan>[
                        TextSpan(text: mobileNumber, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                        const TextSpan(text: ' ارسال کردیم'),
                      ]),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: OTPTextField(
                      controller: otpFieldController,
                      length: 5,
                      width: deviceSize.width,
                      fieldWidth: 40,
                      style: const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceEvenly,
                      fieldStyle: FieldStyle.underline,
                      onCompleted: (pin) => print("Completed: " + pin),
                      onChanged: (pin) {},
                    ),
                  ),
                  const SizedBox(height: 30),
                  remaining == '00:00'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: () {}, child: const Text('دوباره ارسال کن')),
                            const Text('آیا پیامک را دریافت نکردید ؟', style: TextStyle(fontSize: 15)),
                          ],
                        )
                      : Center(child: Text('زمان باقی مانده : $remaining', style: TextStyle(fontSize: 15.0, color: Colors.grey.shade800))),
                  const SizedBox(height: 50),
                  Center(
                    child: Container(
                      width: deviceSize.width - 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ElevatedButton(onPressed: _enterHandler, child: const Text('ورود', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
