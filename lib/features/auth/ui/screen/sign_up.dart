import 'package:axilo/features/auth/controller/auth_controller.dart';
import 'package:axilo/utils/constants/colors.dart' show WColors;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final controller = Get.find<AuthController>(); // Same instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.15),
              Center(
                child: Text("Create Account",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),
              Center(
                child: const Text("Fill your information below or register\n with your social account.",
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 32),
              const Text(
                " Name",
                style: TextStyle(color: WColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: controller.nameController,
                style: const TextStyle(color: WColors.textPrimary),
                decoration: InputDecoration(
                  hintText: "Ex. John Doe",
                  hintStyle: const TextStyle(color: WColors.darkGrey),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                " Email",
                style: TextStyle(color: WColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextField(
                  controller: controller.emailController,
                  style: const TextStyle(color: WColors.textPrimary),
                  decoration: InputDecoration(
                      hintText: "example@gmail.com",
                      hintStyle: const TextStyle(color: WColors.darkGrey),
                      filled: true,
                      fillColor: Colors.grey.shade200)),
              const SizedBox(height: 18),
              const Text(
                " Password",
                style: TextStyle(color: WColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordObscured.value,
                  style: const TextStyle(color: WColors.textPrimary),
                  decoration: InputDecoration(
                      hintText: "********",
                      hintStyle: const TextStyle(color: WColors.darkGrey),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordObscured.value ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      )))),
              SizedBox(height: Get.height * 0.08),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.signUp,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text("Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: WColors.textSecondary, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        children: [TextSpan(text: "Sign In", style: TextStyle(fontWeight: FontWeight.w700))],
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
