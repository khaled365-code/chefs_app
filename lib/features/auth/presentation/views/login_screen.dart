

import 'dart:io';

import 'package:chef_app/core/commons/commons.dart';
import 'package:chef_app/core/utilis/app_text_styles.dart';
import 'package:chef_app/core/widgets/shared_button.dart';
import 'package:chef_app/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:chef_app/features/auth/presentation/widgets/custom_outline_text_field.dart';
import 'package:chef_app/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilis/app_colors.dart';
import '../widgets/dont_have_account_widget.dart';
import '../widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if(state is LoginFailureState)
      {
        showToast(msg: state.errorMessage, toastStates: ToastStates.error);
      }
    if(state is LoginSuccessState)
      {
        showToast(msg: state.successLoginModel.message, toastStates: ToastStates.success);


      }
  },
  builder: (context, state) {
    final loginCubit=BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            LoginHeader(),
            Form(
              key: loginCubit.loginFormKey,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height*579/812,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsetsDirectional.only(start: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          SizedBox(height: 24.h,),
                          Text('Email',style: AppTextStyles.regular13(context).copyWith(color: Color(0xff32343E)),),
                          SizedBox(height: 8.h,),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(end: 24.w),
                            child: CustomOutlineTextField(
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                  {
                                    return 'You must enter your email';
                                  }
                                else
                                  {
                                    return null;
                                  }
                              },
                              onFieldSubmitted: (value)
                              {
                                if(loginCubit.loginFormKey.currentState!.validate())
                                  {
                                   loginCubit.loginFun(email: loginCubit.emailController.text,
                                       password: loginCubit.passwordController.text);
                                  }
                              },
                              controller: loginCubit.emailController,
                              hintText: 'example@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(height: 24.h,),
                          Text('Password',style: AppTextStyles.regular13(context).copyWith(color: Color(0xff32343E)),),
                          SizedBox(height: 8.h,),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(end: 24.w),
                            child: CustomOutlineTextField(
                              obscureText: loginCubit.isObsecureText,
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'You must enter your password';
                                }
                                else
                                {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (value)
                              {
                                if(loginCubit.loginFormKey.currentState!.validate())
                                {
                                  loginCubit.loginFun(email: loginCubit.emailController.text,
                                      password: loginCubit.passwordController.text);
                                }
                              },
                              controller: loginCubit.passwordController,
                              hintText: '* * * * * * * * * *',
                              keyboardType: TextInputType.text,
                              suffixIcon: GestureDetector(
                                onTap: ()
                                  {

                                    loginCubit.changeEyeShape();
                                  },
                                  child: Icon(loginCubit.suffixIcon,color: AppColors.cB4B9CA,)),
                            ),
                          ),
                          SizedBox(height: 24.h,),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(end: 24.w),
                            child: RememberMeWidget(),
                          ),
                          SizedBox(height: 31.h,),
                          state is LoginLoadingState?
                          Center(
                            child: SizedBox(
                              width: 30.w,
                                height: 30.w,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2.w,
                            
                                )),
                          ):
                          Padding(
                            padding:  EdgeInsetsDirectional.only(end: 24.w),
                            child: SharedButton(
                              btnText: 'Log In',
                              onPressessed: ()
                              {
                                if(loginCubit.loginFormKey.currentState!.validate())
                                {
                                  loginCubit.loginFun(email: loginCubit.emailController.text,
                                      password: loginCubit.passwordController.text);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 38.h,),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(start: 38.w),
                            child: DontHaveAccountWidget(),
                          )








                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}