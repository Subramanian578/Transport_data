import 'package:biometric_transport/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignin extends StatefulWidget {
  const GoogleSignin({super.key});

  @override
  State<GoogleSignin> createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State<GoogleSignin> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _signInWithGoogle() async {
    final GoogleSignIn googleSignin = GoogleSignIn();
    await googleSignin.signOut(); // Ensure the user signs out first

    try {
      GoogleSignInAccount? googleUser = await googleSignin.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          print('User signed in: ${user.email}');

          // Navigate to Dashboard and pass the user object
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Dashboard(user: user), // Pass user to Dashboard
            ),
          );
          print('Navigating to Dashboard');
        } else {
          print('Error: User data is null.');
        }
      } else {
        print('Sign In Error: Google user is null.');
      }
    } catch (error) {
      print('Error during Google Sign In: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: screenHeight*0.6,
                  child: Opacity(
                    opacity: 0.8,
                    child: SvgPicture.asset(
                      'assets/hello.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 114, 116, 247),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _signInWithGoogle(); // Call Google Sign-In on button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 114, 116, 247),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Login with Google',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(255, 251, 253, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
