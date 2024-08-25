import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:woauto/i18n/translations.g.dart';
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
                              return t.login_dialog.empty_validation;
                            }

                            if (!s.isEmail) {
                              return t.login_dialog.email_validation;
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text(t.login_dialog.email),
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
                              return t.login_dialog.empty_validation;
                            }

                            if (s.length < 10) {
                              return t.login_dialog.password_validation;
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            label: Text(t.login_dialog.password),
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
                        OverflowBar(
                          spacing: 8,
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
                              label: Text(t.login_dialog.password_forgot),
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
                              label: Text(t.login_dialog.password_generate),
                            ),
                          ],
                        ),
                        24.h,
                        Text(
                          t.login_dialog.password_generate_info,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        OverflowBar(
                          alignment: MainAxisAlignment.end,
                          spacing: 16,
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

                                  await woAutoServer.pb.collection('users').create(body: data);

                                  await woAutoServer.pb
                                      .collection('users')
                                      .authWithPassword(email, password);
                                  woAutoServer.initFriendsLocations();
                                  pop();
                                } on ClientException catch (e) {
                                  var code = e.response['code'];
                                  var message = e.response['message'];
                                  errorText.value = 'Fehler $code:\n$message';
                                }
                              },
                              child: Text(t.login_dialog.register),
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
                                  await woAutoServer.pb
                                      .collection('users')
                                      .authWithPassword(email, password);
                                  woAutoServer.initFriendsLocations();
                                  pop();
                                } on ClientException catch (e) {
                                  var code = e.response['code'];
                                  var message = e.response['message'];
                                  errorText.value = 'Fehler $code:\n$message';
                                }
                              },
                              child: Text(t.login_dialog.login),
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
