
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../navbar/controllers/navbar_controller.dart';
import '../model/update_profile_model.dart';

class ProfileUpdateController extends GetxController {
  RxString gender = 'অন্যান্য'.obs;
  String genderSelect() {
    final map = {
      'পুরুষ': 'male',
      'মহিলা': 'female',
      'অন্যান্য': 'other',
    };
    return map[gender.value] ?? 'others';
  }

  var groupValue = "a";
  final RxBool _isLoading = false.obs;
  RxObjectMixin<ProfileUpdateModel> model = ProfileUpdateModel().obs;

  /// Controllers
  final nameController = TextEditingController(
      text: Get.find<NavbarController>().profileDataModel.value!.user?.name ??
          '');
  final emailController = TextEditingController(
      text: Get.find<NavbarController>().profileDataModel.value!.user!.email ??
          '');
  final organizationController = TextEditingController(
    text: Get.find<NavbarController>().profileDataModel
            .value!
            .user!
            .organization ??
        '',
  );
  final occupationController = TextEditingController(
    text:
    Get.find<NavbarController>().profileDataModel.value!.user!.occupation ??
            '',
  );
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();

  /// Date value using obs
  RxString dob = ''.obs;

  /// Date Picker Function
  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dob.value = picked.toIso8601String().split("T").first;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    pwdController.dispose();
    organizationController.dispose();
    occupationController.dispose();
    confirmPwdController.dispose();
    super.onClose();
  }

  /// Image pick
  RxBool pickedProfileImage = false.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  Rx<CroppedFile?> croppedImage = Rx<CroppedFile?>(null);
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = pickedFile;
      _cropImage(pickedImage.value!.path);
    }
  }

  Future<void> _cropImage(String path) async {
    if (pickedImage.value != null) {
      final croppedFile = await _imageCropper.cropImage(
        sourcePath: pickedImage.value!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 80,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            statusBarColor: LightThemeColors.primaryColor,
            toolbarColor: LightThemeColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            cropGridColor: LightThemeColors.primaryColor,
            cropFrameColor: LightThemeColors.primaryColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              // CropAspectRatioPreset.ratio4x3,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        croppedImage.value = croppedFile;
        pickedProfileImage.value = true;
      }
    }
  }

  /// Method
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  Future<void> updateProfileInfo(context) async {
    _isLoading.value = true;
    String? token = MySharedPref.getUserToken();
    if (token == "" && token.isEmpty) {
      return;
    }
    //






    dio.MultipartFile? imageMultipart;

    if (croppedImage.value != null) {
      XFile xFile = XFile(croppedImage.value!.path);
      imageMultipart = await dio.MultipartFile.fromFile(
        xFile.path,
        filename: nameController.text.trim(),
      );
    }
    String url = AppConstants.updateProfileInfo;


    dio.FormData data = dio.FormData.fromMap({
      'name': nameController.text.trim().toString(),
      'email': emailController.text.trim().toString(),
      'occupation': occupationController.text.trim().toString(),
      'organization': organizationController.text.trim().toString(),
      'gender': genderSelect().toString(),
      'date_of_birth': dob.value.toString(),
      if (pwdController.text.trim().isNotEmpty)
        'password': pwdController.text,
      if (pwdController.text.trim().isNotEmpty)
        'password_confirmation': confirmPwdController.text.trim(),
      'image': imageMultipart ?? '', // fallback if null
    });

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    await BaseClient.safeApiCall(
      url,
      RequestType.post,
      headers: headers,
      data: data,
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;
        if (response.data['status']) {
          _isLoading.value = false;
          ProfileUpdateModel profileData =
              ProfileUpdateModel.fromJson(response.data);
          model.value = profileData;

          CustomSnackBar.showCustomToast(message: response.data['message']);
          Get.find<NavbarController>().getMeProfileInfo();

          Navigator.pop(context);
        } else {
          CustomSnackBar.showCustomSnackBar(
            title: "Something Went Wrong!",
            message: (response.data["message"].toString()),
          );
        }
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
        debugPrint("Logging...");
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        if (error.response?.data['errors'] != null) {
          final errors = error.response!.data['errors'];
          errors.forEach((key, value) {
            CustomSnackBar.showCustomErrorToast(
              message: value[0],
            );
          });
        } else {
          CustomSnackBar.showCustomToast(
            message: error.message,
          );
        }
      },
    );
  }
}
