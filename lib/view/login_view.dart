import 'package:flutter/material.dart';
import 'package:provider_mvvm/resources/components/round_buttons.dart';
import 'package:provider_mvvm/utils/routes/routes.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/view_model/auth_view_mode.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  ValueNotifier<bool> _isObsecurePassword = ValueNotifier<bool>(true);

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(Icons.lock, size: 80),
                  const SizedBox(height: 20),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!value.contains("@")) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  ValueListenableBuilder(
                    valueListenable: _isObsecurePassword,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: _isObsecurePassword.value,
                        focusNode: passwordFocusNode,
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChanged(
                            context,
                            emailFocusNode,
                            passwordFocusNode,
                          );
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_clock_outlined),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObsecurePassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _isObsecurePassword.value
                                  ? _isObsecurePassword.value = false
                                  : _isObsecurePassword.value = true;
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Minimum 6 characters";
                          }
                          return null;
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Login Button
                  RoundButton(
                    onPress: () {
                      if (_emailController.text.isEmpty) {
                        Utils.toastMessage("Please Enter email");
                      } else if (_passwordController.text.isEmpty) {
                        Utils.toastMessage("Please Enter Password");
                      } else if (_passwordController.text.length < 6) {
                        Utils.toastMessage("Please enter minimum 6 digits");
                      } else {
                        Map data = {
                          "username": _emailController.text.toString(),
                          "password": _passwordController.text.toString(),
                        };
                        authViewModel.loginApi(data, context);
                        
                      }
                    },
                    title: "Login",
                    loading: authViewModel.isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
