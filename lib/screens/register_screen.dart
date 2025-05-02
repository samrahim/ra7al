import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ra7al/blocs/authbloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                    CreateUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
                },
                child: const Text('Create Account'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(GoogleSignInRequested());
                },
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Sign up with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //   void _submitForm() {
  //     if (_formKey.currentState!.validate()) {
  //       context.read<AuthBloc>().add(
  //         SignUpRequested(
  //           _emailController.text.trim(),
  //           _passwordController.text.trim(),
  //         ),
  //       );
  //     }
  //   }
}
