import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'reset_password_screen.dart';
import 'api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Image.network(
                "https://cdn-icons-png.flaticon.com/512/747/747376.png",
                width: 100,
                height: 100,
              ), 
              const SizedBox(height: 20),

              // EMAIL
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ), 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The field cannot be empty';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ), 
              const SizedBox(height: 10),

              // PASSWORD
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ), 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The field cannot be empty';
                  }
                  if (value.length < 7) {
                    return 'The password must contain at least 7 characters';
                  }
                  return null;
                },
              ), 
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await api.send("login", {
                      "email": emailController.text,
                      "password": passwordController.text,
                    });

                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (_) => const AlertDialog(
                        title: Text('Successfully'),
                        content: Text("Authorization data has been sent"),
                      ), 
                    );
                  }
                },
                child: const Text("Sign in"),
              ), 
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  );
                },
                child: const Text("Sign up"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
                  );
                },
                child: const Text("Forgot password?"),
              ), 
            ],
          ), 
        ),
      ), 
    ); 
  }
}