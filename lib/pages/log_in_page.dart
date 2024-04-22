import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezi/pages/forgot_password_page.dart';
import 'package:gezi/pages/main_page.dart';
import 'package:gezi/pages/sign_up_page.dart';
import 'package:gezi/services/auth_service.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late Timer timer;

  @override
  void dispose() {
    try {
      timer.cancel();
    } catch (e) {}

    super.dispose();
  }

  void logIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pop(context);
        await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const MainPage()),
            (route) => false);
      } else {
        throw FirebaseAuthException(code: 'not-verified');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('E-mail hatalı'),
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (ctx) {
            return const AlertDialog(
              title: Text('Şifre hatalı'),
            );
          },
        );
      } else if (e.code == 'channel-error') {
        showDialog(
          context: context,
          builder: (ctx) {
            return const AlertDialog(
              title: Text('Geçerli bir e-mail sağladığınızdan emin olun'),
            );
          },
        );
      } else if (e.code == 'not-verified') {
        showDialog(
          context: context,
          builder: (ctx) {
            return const AlertDialog(
              title: Text(
                'Lütfen giriş yapmadan önce mail adresinize gönderilen bağlantıya tıklayarak hesabınızı doğrulayın',
              ),
            );
          },
        );

        timer = Timer.periodic(
          const Duration(seconds: 3),
          (timer) {
            debugPrint('KONTROL EDIYORUM');
            FirebaseAuth.instance.currentUser!.reload();
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              debugPrint('Girdik');
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const MainPage()),
                  (route) => false);
            }
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/p.png',
                  width: 150,
                ),
                const Text(
                  'Hoş Geldin Gezgin!',
                  style: TextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      labelText: 'E-mail',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      labelText: 'Şifre',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Şifreni mi unuttun?',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                        ),
                        backgroundColor: Colors.orange[500],
                      ),
                      onPressed: () {
                        logIn();
                      },
                      child: const Text(
                        'Giriş',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Veya',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Container(
                    color: Colors.orange[100],
                    child: Image.asset(
                      'assets/images/google-logo.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  onTap: () async {
                    await AuthService().signInWithGoogle();
                    if (FirebaseAuth.instance.currentUser != null) {
                      await Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (ctx) => const MainPage()),
                          (route) => false);
                    }
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Üye değil misin?',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const SignUpPage();
                          }));
                        },
                        child: const Text(
                          'Kayıt Ol',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
