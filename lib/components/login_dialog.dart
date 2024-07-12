import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class LoginSheet extends StatefulWidget {
  const LoginSheet({super.key});

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final showPwd = false.obs;
  final countGen = 0.obs;
  final errorText = ''.obs;

  final WoAutoServer woAutoServer = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: AutofillGroup(
            child: Form(
              key: formKey,
              child: Obx(
                () => SafeArea(
                  child: SingleChildScrollView(
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
                            AutofillHints.email,
                            AutofillHints.username,
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

                            if (s.length < 10) {
                              return 'Bitte gebe eine sicheres mind. 10-stelliges Passwort ein';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {});
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
                            AutofillHints.newPassword,
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        if (errorText.isNotEmpty) ...[
                          // 10.h,
                          Text(
                            errorText.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          // 10.h,
                        ],
                        ButtonBar(
                          children: [
                            // pw forget
                            TextButton.icon(
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                var email = emailController.text;
                                // forget password
                                await woAutoServer.pb
                                    .collection('users')
                                    .requestPasswordReset(email);
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
                              onPressed: () async {
                                // Register
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                var email = emailController.text;
                                var password = passwordController.text;
                                try {
                                  var data = {
                                    'username': email.split('@').first,
                                    'email': email,
                                    'emailVisibility': true,
                                    'password': password,
                                    'passwordConfirm': password,
                                  };

                                  var record =
                                      await woAutoServer.pb.collection('users').create(body: data);
                                  pop();
                                } on ClientException catch (e) {
                                  var code = e.response['code'];
                                  var message = e.response['message'];
                                  errorText.value = 'Fehler $code:\n$message';
                                }
                              },
                              child: const Text('Register'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Login
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                var email = emailController.text;
                                var password = passwordController.text;
                                try {
                                  var userData = await woAutoServer.pb
                                      .collection('users')
                                      .authWithPassword(email, password);
                                  pop();
                                } on ClientException catch (e) {
                                  var code = e.response['code'];
                                  var message = e.response['message'];
                                  errorText.value = 'Fehler $code:\n$message';
                                }
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
        ),
      ),
    );
  }
}
