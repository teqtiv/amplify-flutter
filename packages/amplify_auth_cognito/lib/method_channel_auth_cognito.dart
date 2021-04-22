/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import 'package:amplify_core/types/exception/AmplifyException.dart';
import 'package:amplify_core/types/exception/AmplifyExceptionMessages.dart';
import 'package:amplify_core/types/exception/AmplifyAlreadyConfiguredException.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:amplify_auth_plugin_interface/amplify_auth_plugin_interface.dart';
import 'amplify_auth_cognito.dart';
import 'amplify_auth_error_handling.dart';

// ignore_for_file: public_member_api_docs
const MethodChannel _channel =
    MethodChannel('com.amazonaws.amplify/auth_cognito');

/// An implementation of [AmplifyPlatform] that uses method channels.
class AmplifyAuthCognitoMethodChannel extends AmplifyAuthCognito {
  @override
  Future<void> addPlugin() async {
    try {
      return await _channel.invokeMethod('addPlugin');
    } on PlatformException catch (e) {
      if (e.code == "AmplifyAlreadyConfiguredException") {
        throw AmplifyAlreadyConfiguredException(
          AmplifyExceptionMessages.alreadyConfiguredDefaultMessage,
          recoverySuggestion: AmplifyExceptionMessages.alreadyConfiguredDefaultSuggestion);
      } else {
        throw AmplifyException.fromMap(
            Map<String, String>.from(e.details));
      }
    }
  }

  @override
  Future<SignUpResult> signUp({required SignUpRequest request}) async {
    late SignUpResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'signUp',
        <String, dynamic>{
          'data': request.serializeAsMap(),
        },
      )))!;
      res = _formatSignUpResponse(data, "signUp");
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<SignUpResult> confirmSignUp(
      {required ConfirmSignUpRequest request}) async {
    late SignUpResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'confirmSignUp',
        <String, dynamic>{
          'data': request.serializeAsMap(),
        },
      )))!;
      res = _formatSignUpResponse(data, "confirmSignUp");
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<ResendSignUpCodeResult> resendSignUpCode(
      {required ResendSignUpCodeRequest request}) async {
    late ResendSignUpCodeResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'resendSignUpCode',
        <String, dynamic>{
          'data': request.serializeAsMap(),
        },
      )))!;
      res = _formatResendSignUpResponse(data, "resendSignUpCode");
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<SignInResult> signIn({required SignInRequest request}) async {
    late SignInResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'signIn',
        <String, dynamic>{
          'data': request.serializeAsMap(),
        },
      )))!;
      res = _formatSignInResponse(data, "signIn");
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<SignInResult> confirmSignIn({ConfirmSignInRequest? request}) async {
    late SignInResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'confirmSignIn',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : null,
        },
      )))!;
      res = _formatSignInResponse(data, "confirmSignIn");
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<SignOutResult> signOut({SignOutRequest? request}) async {
    late SignOutResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'signOut',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : {},
        },
      )))!;
      res = _formatSignOutResponse(data);
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<UpdatePasswordResult> updatePassword(
      {UpdatePasswordRequest? request}) async {
    late UpdatePasswordResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'updatePassword',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : null,
        },
      )))!;
      res = _formatPasswordResponse(data);
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<ResetPasswordResult> resetPassword(
      {ResetPasswordRequest? request}) async {
    late ResetPasswordResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'resetPassword',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : null,
        },
      )))!;
      res = _formatResetPasswordResponse(data);
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<UpdatePasswordResult> confirmPassword(
      {ConfirmPasswordRequest? request}) async {
    late UpdatePasswordResult res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'confirmPassword',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : null,
        },
      )))!;
      res = _formatPasswordResponse(data);
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<AuthSession> fetchAuthSession({AuthSessionRequest? request}) async {
    late AuthSession res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'fetchAuthSession',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : {},
        },
      )))!;
      res = _formatSessionResponse(data);
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<AuthUser> getCurrentUser({AuthUserRequest? request}) async {
    late AuthUser res;
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'getCurrentUser',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : {},
        },
      )))!;
      res = _formatAuthUserResponse(data);
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<List<AuthUserAttribute>> fetchUserAttributes(
      {AuthUserAttributeRequest? request}) async {
    late List<AuthUserAttribute> res;
    try {
      final List<Map<dynamic, dynamic>> data =
          (await (_channel.invokeListMethod(
        'fetchUserAttributes',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : {},
        },
      )))!;
      res = formatFetchAttributesResponse(data);
      return res;
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }
    return res;
  }

  @override
  Future<SignInResult> signInWithWebUI(
      {SignInWithWebUIRequest? request}) async {
    try {
      final Map<String, dynamic> data =
          (await (_channel.invokeMapMethod<String, dynamic>(
        'signInWithWebUI',
        <String, dynamic>{
          'data': request != null ? request.serializeAsMap() : null,
        },
      )))!;
      return _formatSignInResponse(data, "signIn");
    } on PlatformException catch (e) {
      castAndThrowPlatformException(e);
    }

    throw Exception("Unreachable exception for compiler");
  }

  SignUpResult _formatSignUpResponse(Map<String, dynamic> res, method) {
    return CognitoSignUpResult(
        isSignUpComplete: res["isSignUpComplete"],
        nextStep: AuthNextSignUpStep(
            signUpStep: res["nextStep"]["signUpStep"],
            codeDeliveryDetails: res["nextStep"]["codeDeliveryDetails"],
            additionalInfo: res["nextStep"]["additionalInfo"] is String
                ? jsonDecode(res["nextStep"]["additionalInfo"])
                : {}));
  }

  ResendSignUpCodeResult _formatResendSignUpResponse(
      Map<String, dynamic> res, method) {
    return CognitoResendSignUpCodeResult(
        codeDeliveryDetails: res["codeDeliveryDetails"]);
  }

  SignInResult _formatSignInResponse(Map<String, dynamic> res, String method) {
    return CognitoSignInResult(
        isSignedIn: res["isSignedIn"],
        nextStep: AuthNextSignInStep(
            signInStep: res["nextStep"]["signInStep"],
            codeDeliveryDetails: res["nextStep"]["codeDeliveryDetails"],
            additionalInfo: res["nextStep"]["additionalInfo"] is String
                ? jsonDecode(res["nextStep"]["additionalInfo"])
                : {}));
  }

  UpdatePasswordResult _formatPasswordResponse(Map<String, dynamic> res) {
    return UpdatePasswordResult();
  }

  SignOutResult _formatSignOutResponse(Map<String, dynamic> signOutResponse) {
    return SignOutResult();
  }

  AuthUser _formatAuthUserResponse(Map<String, dynamic> authUserResponse) {
    return AuthUser(
        userId: authUserResponse["userId"],
        username: authUserResponse["username"]);
  }

  List<AuthUserAttribute> formatFetchAttributesResponse(
      List<Map<dynamic, dynamic>> attributeResponse) {
    List<AuthUserAttribute> attributes = [];
    attributeResponse.forEach((element) {
      attributes.add(AuthUserAttribute.init(
          userAttributeKey: element["key"], value: element["value"]));
    });
    return attributes;
  }

  ResetPasswordResult _formatResetPasswordResponse(Map<String, dynamic> res) {
    return CognitoResetPasswordResult(
        isPasswordReset: res["isPasswordReset"],
        nextStep: ResetPasswordStep(
            updateStep: res["nextStep"]["resetPasswordStep"],
            codeDeliveryDetails: res["nextStep"]["codeDeliveryDetails"],
            additionalInfo: res["nextStep"]["additionalInfo"] is String
                ? jsonDecode(res["nextStep"]["additionalInfo"])
                : {}));
  }

  AuthSession _formatSessionResponse(Map<String, dynamic> res) {
    return CognitoAuthSession.init(sessionValues: res);
  }
}
