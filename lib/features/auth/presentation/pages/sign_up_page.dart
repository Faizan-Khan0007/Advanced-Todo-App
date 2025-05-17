import 'package:advanced_todo_app/core/common/widgets/loader.dart';
import 'package:advanced_todo_app/core/theme/app_pallete.dart';
import 'package:advanced_todo_app/core/utils/show_snackbar.dart';
import 'package:advanced_todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advanced_todo_app/features/auth/presentation/pages/login_page.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/two_circles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super
        .dispose(); //always comes up at the last to ensure the parent class is disposed here after sub one
  }

  @override
  Widget build(BuildContext context) {
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
                            "Welcome Onboard!",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              "Lets help you meet your tasks",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          AuthField(
                            texthint: "Enter your username",
                            controller: nameController,
                          ),
                          SizedBox(height: 20),
                          AuthField(
                            texthint: "Enter your Email",
                            controller: emailController,
                          ),
                          SizedBox(height: 20),
                          AuthField(
                            texthint: "Enter Password",
                            controller: passwordController,
                            isobscureText: true,
                          ),
                          SizedBox(height: 20),
                          AuthField(
                            texthint: "Confirm Password",
                            controller: confirmPasswordController,
                            isobscureText: true,
                          ),
                          SizedBox(height: 50),
                          AuthGradientButton(
                            buttonText: "Register",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                 showSnackBar(context, "Password does'nt match");
                                }
                                context.read<AuthBloc>().add(//dispatches the new AuthSignUp event 
                                  AuthSignUp(
                                    email: emailController.text.trim(),
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, LoginPage.route());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: 'Sign In',
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
