import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated && state.message != null) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message!),
          );
        }
      },
      child: Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.local_pharmacy_rounded,
                      size: 64.r,
                      color: colors.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'PharmaChain',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.translate(LangKeys.loginSubtitle),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: context.textStyle,
                      decoration: InputDecoration(
                        labelText: context.translate(LangKeys.email),
                        hintText: context.translate(LangKeys.enterEmail),
                        prefixIcon: const Icon(Icons.email_outlined),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.translate(LangKeys.fieldIsRequired);
                        }
                        if (!value.contains('@')) {
                          return context.translate(LangKeys.invalidEmail);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      style: context.textStyle,
                      decoration: InputDecoration(
                        labelText: context.translate(LangKeys.password),
                        hintText: context.translate(LangKeys.enterPassword),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.translate(LangKeys.fieldIsRequired);
                        }
                        if (value.length < 6) {
                          return context.translate(LangKeys.passwordTooShort);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: _handleForgotPassword,
                        child: Text(
                          context.translate(LangKeys.forgotPassword),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;

                        return SizedBox(
                          height: 48.h,
                          child: FilledButton(
                            onPressed: isLoading ? null : _handleLogin,
                            child: isLoading
                                ? SizedBox(
                                    height: 20.r,
                                    width: 20.r,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colors.surface,
                                    ),
                                  )
                                : Text(
                                    context.translate(LangKeys.login),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                          ),
                        );
                      },
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

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  void _handleForgotPassword() {
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.enterEmailForReset),
      );
      return;
    }

    context.read<AuthCubit>().resetPassword(email: email).then((success) {
      if (success && mounted) {
        ShowToast.showToastSuccessTop(
          message: context.translate(LangKeys.resetPasswordEmailSent),
        );
      }
    });
  }
}
