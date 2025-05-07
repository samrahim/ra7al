import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ra7al/blocs/authbloc/auth_bloc.dart';
import 'package:ra7al/screens/screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  bool obsecure = true;
  bool obsecure1 = true;
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/eee0388dcbe4f3d75252f755ec4ad8687e732e21.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.all(24),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Icon(CupertinoIcons.back, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height * .8,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'إنشاء حساب',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 11, 75, 65),
                              ),
                            ),

                            CustomTextFormField(
                              controller: _usernameController,
                              suffixIcon: Icons.person,
                              hintText: 'إسم المستخدم',
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال إسم المستخدم';
                                }
                                return null;
                              },
                            ),

                            CustomTextFormField(
                              controller: _emailController,
                              suffixIcon: Icons.email,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              hintText: 'البريد الإلكتروني',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال البريد الإلكتروني';
                                }
                                return null;
                              },
                            ),

                            CustomTextFormField(
                              controller: _passwordController,
                              suffixIcon: Icons.key,
                              hintText: 'كلمة المرور',
                              isPasswordField: true,
                              obscureText: obsecure,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              onToggleObscure:
                                  () => setState(() => obsecure = !obsecure),
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'يرجى إدخال كلمة المرور';
                                return null;
                              },
                            ),

                            CustomTextFormField(
                              controller: _passwordController2,
                              suffixIcon: Icons.key,
                              hintText: 'تأكيد كلمة المرور',
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              isPasswordField: true,
                              obscureText: obsecure1,
                              onToggleObscure:
                                  () => setState(() => obsecure1 = !obsecure1),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى تأكيد كلمة المرور';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "لديك حساب ؟",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 11, 75, 65),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController ==
                                          _passwordController2 &&
                                      _emailController.text != '' &&
                                      _usernameController.text != '') {
                                    context.read<AuthBloc>().add(
                                      CreateUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(255, 11, 75, 65),
                                ),
                                child: Center(
                                  child: const Text(
                                    ' تسجيل',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Color.fromARGB(255, 11, 75, 65),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("أو"),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color.fromARGB(255, 11, 75, 65),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

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
                                  child: Image.asset('assets/Group 332.png'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final IconData suffixIcon;
  final bool isPasswordField;
  final bool? obscureText;

  final VoidCallback? onToggleObscure;
  final String? Function(String?)? validator;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    required this.suffixIcon,
    this.isPasswordField = false,
    this.obscureText,
    this.onToggleObscure,
    this.validator,
    this.textDirection,

    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      textDirection: textDirection,

      textAlign: textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 11, 75, 65),
            width: 0.8,
          ),
        ),
        suffixIcon: Icon(suffixIcon),
        prefixIcon:
            isPasswordField
                ? IconButton(
                  onPressed: onToggleObscure,
                  icon: Icon(
                    obscureText! ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : null,
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
