import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Icon(
                      Icons.notifications_outlined,
                      size: 35,
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black54,
                      backgroundImage: NetworkImage(
                        "${FirebaseAuth.instance.currentUser?.photoURL ?? 'https://via.placeholder.com/150'}",
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Text.rich(
                      TextSpan(
                        text:
                            "${FirebaseAuth.instance.currentUser?.displayName ?? 'Guest'}\n",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        children: const [
                          TextSpan(
                            text: "Show profile",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black12),
                const SizedBox(height: 10),
                const Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                profileInfo(Icons.person_2_outlined, "Personal information"),
                profileInfo(Icons.security, "Login & security"),
                profileInfo(Icons.payments_outlined, "Payments and payouts"),
                profileInfo(Icons.settings_outlined, "Accessibility"),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => _logout(context),
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding profileInfo(icon, name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 35,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(width: 20),
              Text(
                name,
                style: const TextStyle(fontSize: 17),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black12),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to login
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("  : ${e.toString()}")),
      );
    }
  }
}
