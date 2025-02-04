import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Authontications_Screens/sign_in.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/bottom_nave_screen.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conPasswordController = TextEditingController();

  bool _isObscure = true;

  addDetails() async {
    final name = _fullnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final compassowrd = _conPasswordController.text.trim();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        compassowrd.isNotEmpty) {
      final details = Usermodel(
          fullName: name, email: email, password: password, isLog: true);
      addSignUp(details);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => BottomNaveScreen(
                    id: details.id,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        AssetImage('asset/Splashess_Images/Loging_Image.jpg'))),
          ),
          Positioned(
              top: 55,
              left: 33,
              child: Text(
                'Create \nAccount',
                style: GoogleFonts.fredoka(
                    fontSize: 32,
                    color: appcolorwhite,
                    fontWeight: FontWeight.w600),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 600,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appcolorwhite,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          'asset/Splashess_Images/Fit_Form.png',
                          width: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 30, 0),
                          child: TextFormField(
                            controller: _fullnameController,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              hintStyle: GoogleFonts.josefinSans(
                                  color: appcolorwhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: appcolorwhite,
                              ),
                            ),
                            style: GoogleFonts.jost(
                                color: appcolorwhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your full name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 35, 0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.attach_email_outlined,
                                  color: appcolorwhite,
                                ),
                                hintText: 'Email',
                                hintStyle: GoogleFonts.josefinSans(
                                    color: appcolorwhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            style: GoogleFonts.jost(
                                color: appcolorwhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your email';
                              }
                              final emailRegex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 30, 0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: GoogleFonts.josefinSans(
                                  color: appcolorwhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.lock_person_outlined,
                                color: appcolorwhite,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  color: appcolorwhite,
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                            style: GoogleFonts.jost(
                                color: appcolorwhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a password';
                              }
                              if (value.length < 6) {
                                return 'password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 35, 0),
                          child: TextFormField(
                            controller: _conPasswordController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_person_outlined,
                                  color: appcolorwhite,
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: GoogleFonts.josefinSans(
                                    color: appcolorwhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            style: GoogleFonts.jost(
                                color: appcolorwhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'password do not match';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _passwordController,
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: appcolorwhite,
                              minimumSize: const Size(240, 42),
                              side: BorderSide(color: appcolorRed, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addDetails();
                              }
                              snackBarMessenger(context, 'Successfully Created an Account', appcolorgreen);
                            },
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.fredoka(
                                  color: appcolorblack,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Dont have an account?',
                                    style: GoogleFonts.josefinSans(
                                        color: appcolorwhite),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => SignIn()));
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: GoogleFonts.fredoka(
                                            color: appcolorwhite,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
