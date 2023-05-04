import 'package:exam/providers/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './authenticate_screen.dart';
import '../widgets/elements/spinner.dart';

//-------------------------------------------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  // ---------------- feilds ------------------
  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ---------------- state ------------------
// uniqe key for form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // phone number state
  String? _mobileNumber;
  // validate the mobile number
  bool isValid = false;
  // loading
  var _isLoading = false;
  // user data
  int? _id;
  int? _otp_token;
  // ---------------- methods ------------------
// to submit form and login
  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) return; //stop the function execution if any of inputs is not valid
    setState(() {
      _isLoading = true;
    });
    final userData = await Provider.of<Auth>(context, listen: false).login(_mobileNumber.toString());
    setState(() {
      _id = userData['id'];
      _otp_token = userData['otp_token'];
      _isLoading = false;
    });
    Map<String, dynamic> myArguments = {'id': _id, 'otp_token': _otp_token, 'mobileNumber': _mobileNumber};
    Navigator.of(context).pushNamed(AuthenticateScreen.routeName, arguments: myArguments);
  }

  // ---------------- UI ------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: _isLoading
          ? const Spinner()
          : SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 58),
                    child: Image.asset('assets/images/Exam.png', fit: BoxFit.fill, width: deviceSize.width - 100),
                  ),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text('ورود به سامانه آزمون الکنرونیک', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                const SizedBox(height: 15),
                Center(child: Text('یک پیامک شامل کد یکبار مصرف برای شما ارسال خواهد شد', style: TextStyle(fontSize: 15, color: Colors.grey.shade600))),
                const SizedBox(height: 50),
                Center(child: Text('شماره موبایل خود را وارد کنید', style: TextStyle(color: Colors.grey.shade600))),
                const SizedBox(height: 15),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: deviceSize.width - 170,
                            child: TextFormField(
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.phone,
                              validator: (String? value) {
                                if (value == null || value.isEmpty || value.length != 11) return 'لطفا شماره تلفن همراه خود را وارد کنید';
                                setState(() {
                                  _mobileNumber = value;
                                });
                                return null;
                              },
                              onSaved: (String? value) {
                                _mobileNumber = value!;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: Container(
                            width: deviceSize.width - 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ElevatedButton(onPressed: _submitForm, child: const Text('دریافت کد تایید', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
    );
  }
}

// return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 90),
//               width: 200,
//               height: 200,
//               decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/Exam.png'))),
//             ),
//           ),
//           Center(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     width: deviceSize.width - 50,
//                     decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
//                     child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: 'شماره موبایل',
//                         fillColor: Colors.grey[200],
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty || value.length != 11) return 'لطفا شماره تلفن همراه خود را وارد کنید';
//                         return null;
//                       },
//                       onSaved: (String? value) {
//                         _mobileNumber = value!;
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     width: deviceSize.width - 50,
//                     height: 45,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: ElevatedButton(onPressed: _submitForm, child: const Text('ورود')),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
