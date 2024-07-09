import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/extensions.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final showPwd = false.obs;
  final countGen = 0.obs;

  final WoAutoServer woAutoServer = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        title: const Text('WoAuto Login'),
        content: AutofillGroup(
          child: Form(
            key: formKey,
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return 'Bitte gebe etwas ein';
                        }

                        if (!s.isEmail) {
                          return 'Bitte gebe eine gültige E-Mail Adresse ein';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('E-Mail'),
                      ),
                      autofillHints: const [
                        AutofillHints.name,
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return 'Bitte gebe ein Passwort ein';
                        }

                        if (s.length > 10) {
                          return 'Bitte gebe eine sicheres mind. 10-stelliges Passwort ein';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            showPwd.value ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => showPwd.toggle(),
                        ),
                        counterText: passwordController.value.text.length.toString(),
                      ),
                      obscureText: !showPwd.value,
                      autofillHints: const [
                        AutofillHints.password,
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    ButtonBar(
                      children: [
                        // pw forget
                        TextButton.icon(
                          onPressed: () async {
                            var email = emailController.text;
                            if (!email.isEmail) {
                              return;
                            }
                            // forget password
                            await woAutoServer.pb.collection('users').requestPasswordReset(email);
                          },
                          icon: const Text('😢'),
                          label: const Text('Passwort vergessen'),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // gen password
                            const alphabet =
                                'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

                            Random r = Random.secure();
                            // pwd = 4444-4444-4444 with the -
                            int length = 4;
                            String password = List.generate(length, (_) {
                              return List.generate(length, (_) {
                                return alphabet[r.nextInt(alphabet.length)];
                              }).join();
                            }).join('-');
                            passwordController.text = password;

                            setState(() {});

                            countGen.value++;
                          },
                          icon: const Text('✨'),
                          label: const Text('Passwort generieren'),
                        ),
                      ],
                    ),
                    24.h,
                    const Text(
                      'Dein Passwort wird beim generieren in das Textfeld eingefügt. Es wird nicht von uns gespeichert! Guck dir den Code an, wenn du dir nicht sicher bist!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Register
                          },
                          child: const Text('Register'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Login
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}