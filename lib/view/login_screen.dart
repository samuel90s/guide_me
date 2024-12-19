import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guide_me/Authentication/google_authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuthServices().signOut();
  }

  Future<void> signInWithEmailPassword() async {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login with Email/Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacementNamed(context, '/home');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Login failed: ${e.toString()}")),
                );
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> signInWithPhone() async {
    final phoneController = TextEditingController();
    final otpController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login with Phone Number"),
        content: TextField(
          controller: phoneController,
          decoration: const InputDecoration(labelText: "Phone Number"),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close phone dialog
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: phoneController.text.trim(),
                verificationCompleted: (PhoneAuthCredential credential) async {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                verificationFailed: (FirebaseAuthException e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Verification failed: ${e.message}")),
                  );
                },
                codeSent: (verificationId, resendToken) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Enter OTP"),
                      content: TextField(
                        controller: otpController,
                        decoration: const InputDecoration(labelText: "OTP"),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            final credential = PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otpController.text.trim(),
                            );
                            await FirebaseAuth.instance.signInWithCredential(credential);
                            Navigator.pop(context); // Close OTP dialog
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          child: const Text("Verify"),
                        ),
                      ],
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (verificationId) {},
              );
            },
            child: const Text("Send OTP"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Log in or sign up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: Colors.black12),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to Guide Me",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    GestureDetector(
                      onTap: signInWithPhone,
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pink,
                        ),
                        child: const Center(
                          child: Text(
                            "Continue with Phone",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await signOutGoogle();
                          await FirebaseAuthServices().signInWithGoogle();
                          if (mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login failed: $e")),
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : socialIcons(size, Icons.email_outlined, "Continue with Google", Colors.red, 24),
                    ),
                    socialIcons(
                      size,
                      Icons.email_outlined,
                      "Continue with Email",
                      Colors.black,
                      24,
                      onTap: signInWithEmailPassword,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding socialIcons(Size size, IconData icon, String name, Color color,
      double iconSize, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(),
          ),
          child: Row(
            children: [
              SizedBox(width: size.width * 0.05),
              Icon(icon, color: color, size: iconSize),
              SizedBox(width: size.width * 0.1),
              Text(name, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
