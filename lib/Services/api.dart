
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:kolazz_book/Controller/edit_client_model.dart';
import 'package:kolazz_book/Models/event_type_model.dart';
import 'package:kolazz_book/Models/first_veryfy_otp_response.dart';
import 'package:kolazz_book/Models/forgot_password.dart';
import 'package:kolazz_book/Models/photographer_client_model.dart';
import 'package:kolazz_book/Models/login_response_model.dart';
import 'package:kolazz_book/Models/resister_user_response.dart';
import 'package:kolazz_book/Models/verify_otp.dart';

import '../Models/client_model.dart';
import '../Models/get_quotation_model.dart';
import '../Models/Type_of_photography_model.dart';
import '../Models/add_clientmodel.dart';
import '../Models/add_photographermodel.dart';
import '../Models/add_quatation_model.dart';
import '../Models/faq_model.dart';
import '../Models/get_profile_model.dart';
import '../Models/logout_model.dart';
import '../Models/subscription_model.dart';
import '../Models/tnc&privacy_policy_model.dart';
import '../Models/update_profile_model.dart';
import 'api_client.dart';
import 'api_methods.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api _api = Api._internal();

final Connectivity connectivity = Connectivity();

  //final Connectivity? connectivity;

  factory Api() {
    return _api;
  }

  Api._internal();

  Map<String, String> getHeader() {
    return {'Cookie': 'ci_session=c35fa031f74710f20bf26fea3b4ccd7bfe18332a'};
    // return {'Content-Type': 'application/json'};
  }

  // Future<RegisterUserResponse> registerUserApi(Map<String, String> body) async {
  //   if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
  //       await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
  //     String res =
  //     await _apiClient.postMethod(method: _apiMethods.registerUser, body: body);
  //     if (res.isNotEmpty) {
  //       try {
  //         return registerUserResponseFromJson(res);
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print(e);
  //         }
  //         return RegisterUserResponse(error: true, message: e.toString());
  //       }
  //     } else {
  //       return RegisterUserResponse(error: true, message: 'Something went wrong');
  //     }
  //   } else {
  //     return RegisterUserResponse(error: true, message: 'No Internet');
  //   }
  // }

  Future<LoginResponseModel> loginUserApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.login, body: body);
      if (res.isNotEmpty) {
        try {
          return loginResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return LoginResponseModel(error: true, message: e.toString(), );
        }
      } else {
        return LoginResponseModel(error: false, message: 'Something went wrong', );
      }
    } else {
      return LoginResponseModel(error: false, message: 'No Internet',);
    }
  }

  Future<RegisterUserResponse> registerUpi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.registerUser, body: body);
      if (res.isNotEmpty) {
        try {
          return registerUserResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return RegisterUserResponse(error: true, message: e.toString(), );
        }
      } else {
        return RegisterUserResponse(error: false, message: 'Something went wrong', );
      }
    } else {
      return RegisterUserResponse(error: false, message: 'No Internet',);
    }
  }

  Future<ResendOtpResponse> resendOTPApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.sendOtp, body: body);
      if (res.isNotEmpty) {
        try {
          return resendOtpResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ResendOtpResponse(error: true, message: e.toString(), );
        }
      } else {
        return ResendOtpResponse(error: false, message: 'Something went wrong', );
      }
    } else {
      return ResendOtpResponse(error: false, message: 'No Internet',);
    }
  }

  Future<VerifyOtpResponse> verifyOTPApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.OtpVerify, body: body);
      if (res.isNotEmpty) {
        try {
          return verifyOtpResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return VerifyOtpResponse(error: true, message: e.toString(), );
        }
      } else {
        return VerifyOtpResponse(error: false, message: 'Something went wrong', );
      }
    } else {
      return VerifyOtpResponse(error: false, message: 'No Internet',);
    }
  }


Future<ForgotPassword> resetPasswordApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.forgotpassword, body: body);
      if (res.isNotEmpty) {
        try {
          return forgotPasswordFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ForgotPassword(status: 1, msg: e.toString());
        }
      } else {
        return ForgotPassword(status: 2, msg: 'Something went wrong');
      }
    } else {
      return ForgotPassword(status: 2, msg: 'No Internet');
    }
  }

Future<GetProfileModel> getProfile(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getProfile, body: body);
      if (res.isNotEmpty) {
        try {
          return getProfileModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetProfileModel(error: false, message: e.toString());
        }
      } else {
        return GetProfileModel(error: true, message: 'Something went wrong');
      }
    } else {
      return GetProfileModel(error: true, message: 'No Internet');
    }
  }

Future<UpdateProfile> updateProfileApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.updateProfile, body: body);
      if (res.isNotEmpty) {
        try {
          return updateProfileFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return UpdateProfile(status: "success" , message: e.toString());
        }
      } else {
        return UpdateProfile(status: "failure", message: 'Something went wrong');
      }
    } else {
      return UpdateProfile(status: "failure", message: 'No Internet');
    }
  }

  Future<AddPhotographer> addPhotographeApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addphotographer, body: body);
      if (res.isNotEmpty) {
        try {
          return addPhotographerFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddPhotographer(error:false , message: e.toString(), );
        }
      } else {
        return AddPhotographer(error: false, message: 'Something went wrong', );
      }
    } else {
      return AddPhotographer(error: false, message: 'No Internet',);
    }
  }

  Future<Addclientmodel> addClientApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addclient, body: body);
      if (res.isNotEmpty) {
        try {
          return addclientmodelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return Addclientmodel(error:false , message: e.toString(), );
        }
      } else {
        return Addclientmodel(error: false, message: 'Something went wrong', );
      }
    } else {
      return Addclientmodel(error: false, message: 'No Internet',);
    }
  }

  Future<EditClientModel> editClientPhotographer(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.editClientPhotoApi, body: body);
      if (res.isNotEmpty) {
        try {
          return editClientModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return EditClientModel(error:false , message: e.toString(), );
        }
      } else {
        return EditClientModel(error: false, message: 'Something went wrong', );
      }
    } else {
      return EditClientModel(error: false, message: 'No Internet',);
    }
  }

  Future<PhotographerClientModel> getPhtographerclintApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getphotoclient, body: body);
      if (res.isNotEmpty) {
        try {
          return photographerClientModelFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return PhotographerClientModel(responseCode: '1', msg: e.toString());
        }
      } else {
        return PhotographerClientModel(responseCode: '0', msg: 'Something went wrong');
      }
    } else {
      return PhotographerClientModel(responseCode: '0', msg: 'No Internet');
    }
  }


  Future<ClientModel> getclintApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getphotoclient, body: body);
      if (res.isNotEmpty) {
        try {
          return clientModelFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return ClientModel(responseCode: '1', msg: e.toString());
        }
      } else {
        return ClientModel(responseCode: '0', msg: 'Something went wrong');
      }
    } else {
      return ClientModel(responseCode: '0', msg: 'No Internet');
    }
  }


  Future<PhotographerClientModel> getQuotationsApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getphotoclient, body: body);
      if (res.isNotEmpty) {
        try {
          return photographerClientModelFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return PhotographerClientModel(responseCode: '1', msg: e.toString());
        }
      } else {
        return PhotographerClientModel(responseCode: '0', msg: 'Something went wrong');
      }
    } else {
      return PhotographerClientModel(responseCode: '0', msg: 'No Internet');
    }
  }

  Future<TypeofPhotography> getPhotographertypeApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getRventstype, body: body);
      if (res.isNotEmpty) {
        try {
          return typeofPhotographyFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return TypeofPhotography(status: 1, msg: e.toString());
        }
      } else {
        return TypeofPhotography(status: 0, msg: 'Something went wrong');
      }
    } else {
      return TypeofPhotography(status: 1, msg: 'No Internet');
    }
  }

  Future<EventTypeModel> getEventTypeApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getEventType, body: body);
      if (res.isNotEmpty) {
        try {
          return eventTypeFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return EventTypeModel(status: 1, msg: e.toString());
        }
      } else {
        return EventTypeModel(status: 0, msg: 'Something went wrong');
      }
    } else {
      return EventTypeModel(status: 1, msg: 'No Internet');
    }
  }

  Future<AddQuatation> addnewQuatationApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addquatation, body: body);
      if (res.isNotEmpty) {
        try {
          return addQuatationFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddQuatation(error:false , message: e.toString(), );
        }
      } else {
        return AddQuatation(error: false, message: 'Something went wrong', );
      }
    } else {
      return AddQuatation(error: false, message: 'No Internet',);
    }
  }

  Future<Getsetting> GetTncPrivacyPolicyApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getSetting, body: body);
      if (res.isNotEmpty) {
        try {
          return getsettingFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return Getsetting(status:'1', msg: e.toString());
        }
      } else {
        return Getsetting(status:'0', msg: 'Something went wrong');
      }
    } else {
      return Getsetting(status:'0', msg: 'No Internet');
    }
  }

  Future<Faq> getFaqApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getfaq, body: body);
      if (res.isNotEmpty) {
        try {
          return faqFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return Faq(status:'1', msg: e.toString());
        }
      } else {
        return Faq(status:'0', msg: 'Something went wrong');
      }
    } else {
      return Faq(status:'0', msg: 'No Internet');
    }
  }

  Future<SubscriptionModel> getSubscriptionApi(Map<String, String> body) async  {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getPlan, body: body);
      if (res.isNotEmpty) {
        try {
          return subscriptionModelFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return SubscriptionModel(responseCode:'1', msg: e.toString());
        }
      } else {
        return SubscriptionModel(responseCode:'0', msg: 'Something went wrong');
      }
    } else {
      return SubscriptionModel(responseCode:'0', msg: 'No Internet');
    }
  }

  Future<GetQuotationModel> getQuotationsAPI(Map<String, String> body) async  {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getQuotation, body: body);
      if (res.isNotEmpty) {
        try {
          return getQuotationModelFromJson(res);

        } catch (e) {
          if (kDebugMode) {
            print(e);
            print('____fdgfd______${e}___________');
          }
          return GetQuotationModel(status: false, msg: e.toString());
        }
      } else {
        return GetQuotationModel(status:false, msg: 'Something went wrong');
      }
    } else {
      return GetQuotationModel(status: false, msg: 'No Internet');
    }
  }


  Future<LogoutModel> logoutApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.logout, body: body);
      if (res.isNotEmpty) {
        try {
          return logoutModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return LogoutModel(status: "1" , msg: e.toString());
        }
      } else {
        return LogoutModel(status: "0", msg: 'Something went wrong');
      }
    } else {
      return LogoutModel(status: "0", msg: 'No Internet');
    }
  }

  Future<LogoutModel> logoutAllDeviceApi(Map<String, String> body) async  {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.logoutAllDevices, body: body);
      if (res.isNotEmpty) {
        try {
          return logoutModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return LogoutModel(status: "1" , msg: e.toString());
        }
      } else {
        return LogoutModel(status: "0", msg: 'Something went wrong');
      }
    } else {
      return LogoutModel(status: "0", msg: 'No Internet');
    }
  }


}