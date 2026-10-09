import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/home/screens/bottom_nave_screen.dart';
import 'package:fit_form/features/auth/screens/sign_up.dart';
import 'package:fit_form/features/auth/widgets/auth_text_field.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  Future<void> _handleSignIn() async {
    if (!mounted) return;
    
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final user = await addsignIn(email, password);
        if (!mounted) return;
        
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNaveScreen(id: user.id!)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed, incorrect email or password.')),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed, try again.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      decoration: BoxDecoration(
        border: GradientBoxBorder(
            gradient: LinearGradient(colors: [appcolorwhite, appcolorRed]),
            width: 2),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('asset/Splashess_Images/Fit_Form.png', width: 200),
            AuthTextField(
              controller: _emailcontroller,
              hintText: 'Email',
              icon: Icons.attach_email_outlined,
              validator: (value) => value == null || value.isEmpty ? 'enter your Email' : null,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              controller: _passwordcontroller,
              hintText: 'Password',
              icon: Icons.lock_person_outlined,
              isObscure: _isObscure,
              suffixIcon: IconButton(
                icon: Icon(
                  color: appcolorwhite,
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(() => _isObscure = !_isObscure),
              ),
              validator: (value) => value == null || value.isEmpty ? 'enter your password' : null,
            ),
            const SizedBox(height: 100),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: appcolorwhite,
                minimumSize: const Size(240, 42),
                side: BorderSide(color: appcolorRed, width: 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  await _handleSignIn();
                }
              },
              child: Text(
                'Sign In',
                style: GoogleFonts.fredoka(color: appcolorblack, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Dont have an account?', style: GoogleFonts.josefinSans(color: appcolorwhite)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (_) => const SignUp()));
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.fredoka(color: appcolorwhite, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
