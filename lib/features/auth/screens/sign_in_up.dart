// import 'package:fit_form/App_Colors/app_colors.dart';
// import 'package:fit_form/features/auth/screens/sign_in.dart';
// import 'package:fit_form/features/auth/screens/sign_up.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SignInUp extends StatelessWidget {
//   const SignInUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage('asset/Splashess_Images/Loging_Image.jpg'))),
//           ),
//           Positioned(
//               top: 360,
//               left: 31,
//               right: 31,
//               child: Container(
//                 height: 400,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: appcolorRed,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(32.0), // Uniform radius
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Image.asset(
//                       'asset/Splashess_Images/Fit_Form.png',
//                       width: 200,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       'Welcome',
//                       style: GoogleFonts.fredoka(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: appcolorwhite),
//                     ),
//                     const SizedBox(
//                       height: 60,
//                     ),
//                     OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           backgroundColor: appcolorwhite,
//                           minimumSize: const Size(240, 42),
//                           side:  BorderSide(color: appcolorRed, width: 1),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => const SignIn()));
//                         },
//                         child: Text(
//                           'Sign In',
//                           style: GoogleFonts.fredoka(
//                               color: appcolorblack, fontWeight: FontWeight.bold),
//                         )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           backgroundColor: appcolorRed,
//                           minimumSize: const Size(240, 42),
//                           side:  BorderSide(color: appcolorwhite, width: 1),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) =>  SignUp()));
//                         },
//                         child: Text(
//                           'Sign Up',
//                           style: GoogleFonts.fredoka(
//                               color: appcolorwhite, fontWeight: FontWeight.bold),
//                         )),
//                   ],
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
