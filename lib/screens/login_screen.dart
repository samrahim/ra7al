import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ra7al/blocs/authbloc/auth_bloc.dart';
import 'package:ra7al/screens/screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool obsecure = true;

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is Authenticated) {
              context.go('/home');
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Image.asset(
                  'assets/eee0388dcbe4f3d75252f755ec4ad8687e732e21.png',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'سجل دخولك',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller: emailController,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.ltr,
                                    decoration: const InputDecoration(
                                      hintText: 'البريد الإلكتروني',

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller: passwordController,
                                    textAlign: TextAlign.right,
                                    obscureText: obsecure,

                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        onPressed:
                                            () => setState(
                                              () => obsecure = !obsecure,
                                            ),
                                        icon:
                                            obsecure
                                                ? Icon(Icons.visibility)
                                                : Icon(Icons.visibility_off),
                                      ),
                                      hintText: 'كلمة المرور',

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('هل نسيت كلمة السر؟'),
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: const Text(
                                        ' دخول',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                            255,
                                            11,
                                            75,
                                            65,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                      LoginRequested(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      ),
                                    );
                                  },
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => RegisterScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'تسجيل',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            112,
                                            41,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'لا تملك حسابا؟',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                Text('او سجل بواسطة'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read<AuthBloc>().add(
                                          GoogleSignInRequested(),
                                        );
                                      },
                                      child: Image.asset('assets/image 2.png'),
                                    ),
                                    SizedBox(width: 16),
                                    InkWell(
                                      onTap: () {
                                        context.read<AuthBloc>().add(
                                          FacebookSignInRequested(),
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/Group 332.png',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
