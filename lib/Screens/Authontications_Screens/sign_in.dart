import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Authontications_Screens/sign_up.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isObscure = true;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  Future<void> isSignIn() async {
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        addsignIn(email, password, context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed, try again.')),
        );
      }
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
                'Hello \nSign In',
                style: GoogleFonts.fredoka(
                    fontSize: 32,
                    color: appcolorwhite,
                    fontWeight: FontWeight.w600),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Center(
              child: SingleChildScrollView(
                  child: Container(
                height: 650,
                decoration: BoxDecoration(
                  border: GradientBoxBorder(
                      gradient:
                          LinearGradient(colors: [appcolorwhite, appcolorRed]),
                      width: 2),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Form(
                  key: _formkey,
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
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: GoogleFonts.josefinSans(
                                color: appcolorwhite,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
                              Icons.attach_email_outlined,
                              color: appcolorwhite,
                            ),
                          ),
                          style: GoogleFonts.jost(
                              color: appcolorwhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your Email';
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
                          controller: _passwordcontroller,
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
                              return 'enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 100,
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
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              await isSignIn();
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.fredoka(
                                color: appcolorblack,
                                fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
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
                                              builder: (_) => SignUp()));
                                    },
                                    child: Text(
                                      'Sign Up',
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
              )),
            ),
          )
        ],
      ),
    );
  }
}
