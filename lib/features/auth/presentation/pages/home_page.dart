import 'package:advanced_todo_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/two_circles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TwoCircles(),
          Center(
            // Apply padding to shift the image upwards
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/login.png'),
                          fit:
                              BoxFit.cover, // Ensures the image covers the container properly
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Get Your Things done with todo",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Welcome to your personal productivity hub!\n   Stay organized, manage your tasks,and \nachieve more with our advanced To-Do app.",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 20),
                   AuthGradientButton(buttonText: "Get Started",onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
                   },),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
