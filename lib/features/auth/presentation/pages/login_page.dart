// ignore_for_file: unused_element

import 'package:advanced_todo_app/core/common/widgets/loader.dart';
import 'package:advanced_todo_app/core/theme/app_pallete.dart';
import 'package:advanced_todo_app/core/utils/show_snackbar.dart';
import 'package:advanced_todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advanced_todo_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/two_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    return Scaffold(
      body: Stack(
        children: [
          TwoCircles(),
          Center(
            // Apply padding to shift the image upwards
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if(state is AuthFailure){
                      showSnackBar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    if(state is AuthLoading){
                      return const Loader();
                    }
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/signin.png'),
                                  fit:
                                      BoxFit
                                          .cover, // Ensures the image covers the container properly
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          AuthField(
                            texthint: "Enter your Email",
                            controller: emailController,
                          ),
                          SizedBox(height: 20),
                          AuthField(
                            texthint: "Enter your Password",
                            controller: passwordController,
                            isobscureText: true,
                          ),
                          SizedBox(height: 20),
                          AuthGradientButton(
                            buttonText: "Login",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  //dispatches the new AuthSignUp event
                                  AuthLogin(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, SignUpPage.route());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color: AppPallete.gradient1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
