// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/core/utils/app_functions.dart';
import 'package:iteach/feature/data/models/user_model.dart';
import 'package:iteach/feature/presentation/controllers/profile_controller.dart';
import 'package:iteach/feature/presentation/pages/login_page/login_page.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/text_field_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Container(
        color: AppColors.bgColor,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.titleColor,
                  fontSize: 20.sp,
                ),
              ),
              backgroundColor: AppColors.bgColor,
            ),
            body: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.widgetColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //MALUMOTLAR
                          Text(
                            controller.isEditing
                                ? 'Tahrirlash'
                                : 'Ma\'lumotlar',
                            style: TextStyle(
                              color: AppColors.widgetColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          //CONTAINER
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.bgColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                  color: Colors.black.withOpacity(0.5),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0.r),
                              child: controller.isEditing

                                  //EDIT
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  controller.editing(false);
                                                },
                                                child: Container(
                                                  color: AppColors.bgColor,
                                                  child: Text(
                                                    'Chiqish',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.widgetColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextFieldWidget(
                                            title: 'Ism',
                                            isName: true,
                                            controller: controller.nameCtr,
                                            controllerH: controller,
                                          ),
                                          SizedBox(height: 12.h),
                                          TextFieldWidget(
                                            title: 'Email',
                                            isEmail: true,
                                            controller: controller.emailCtr,
                                            controllerH: controller,
                                          ),
                                          SizedBox(height: 12.h),
                                          TextFieldWidget(
                                            title: 'Parol',
                                            isPassword: true,
                                            controller: controller.passwordCtr,
                                            controllerH: controller,
                                          ),
                                          SizedBox(height: 12.h),
                                          TextFieldWidget(
                                            title: 'Telefon raqam',
                                            isPhone: true,
                                            controller: controller.phoneCtr,
                                            controllerH: controller,
                                          ),
                                          SizedBox(height: 20.h),
                                          GestureDetector(
                                            onTap: () async {
                                              if (controller.isValide) {
                                                if (controller.isChanged) {
                                                  await controller.changeUser(
                                                    UserModel(
                                                      fullName: controller
                                                          .nameCtr.text,
                                                      email: controller
                                                          .emailCtr.text,
                                                      password: controller
                                                          .passwordCtr.text,
                                                      phoneNumber: controller
                                                          .phoneCtr.text,
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: Container(
                                              height: 56,
                                              decoration: BoxDecoration(
                                                color: controller.isChanged &&
                                                        controller.isValide
                                                    ? AppColors.widgetColor
                                                    : AppColors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: controller.isLoading2
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                            color:
                                                                AppColors.white,
                                                            strokeWidth: 2,
                                                          ))
                                                        : Text(
                                                            'O\'zgartirish',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )

                                  //PROFILE
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //EDIT
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                controller.editing(true);
                                              },
                                              child: Container(
                                                color: AppColors.bgColor,
                                                child: Text(
                                                  'O\'zgartirish',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.widgetColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        //IMAGE
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (controller
                                                      .isUploadImage) {
                                                  } else {
                                                    return await controller
                                                        .pickAndUploadPhoto();
                                                  }
                                                },
                                                child: Container(
                                                  width: 160,
                                                  height: 160,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: controller
                                                              .isUploadImage
                                                          ? AppColors.white
                                                          : AppColors
                                                              .widgetColor),
                                                  child: controller.userInfo!
                                                              .image ==
                                                          null
                                                      ? Icon(
                                                          Icons.image,
                                                          color:
                                                              AppColors.white,
                                                          size: 32.w,
                                                        )
                                                      : SizedBox(
                                                          width: 160,
                                                          height: 160,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl: AppFunctions
                                                                  .imageUrl(controller
                                                                      .userInfo!
                                                                      .image!),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              controller.isUploadImage
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        await controller
                                                            .pickAndUploadPhoto();
                                                      },
                                                      child: Text(
                                                        'Rasmni yangilash',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .widgetColor,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        await controller
                                                            .pickAndUploadPhoto();
                                                      },
                                                      child: Text(
                                                        'Rasmni joylash',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .widgetColor,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),

                                              SizedBox(height: 12.h),
                                              //ism
                                              Text(
                                                controller.userInfo!.fullName!,
                                                style: TextStyle(
                                                    color: AppColors.titleColor,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                color: AppColors.grey
                                                    .withOpacity(0.5),
                                                width:
                                                    ScreenUtil().screenWidth /
                                                        2,
                                                height: 1,
                                              ),

                                              //phone
                                              Text(
                                                AppFunctions.formatPhone(
                                                    controller.userInfo!
                                                        .phoneNumber!),
                                                style: TextStyle(
                                                  color: AppColors.widgetColor,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              Container(
                                                color: AppColors.grey
                                                    .withOpacity(0.5),
                                                width:
                                                    ScreenUtil().screenWidth /
                                                        2,
                                                height: 1,
                                              ),

                                              //email
                                              Text(
                                                controller.userInfo!.email!,
                                                style: TextStyle(
                                                  color: AppColors.widgetColor,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),

                                        Center(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await controller.exitProfile();
                                              Get.offAll(LoginPage());
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.widgetColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12.0,
                                                  vertical: 8,
                                                ),
                                                child: Text('Chiqish'),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
