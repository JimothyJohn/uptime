/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the StripeBillingDetails type in your schema. */
class StripeBillingDetails {
  final CustomerAddress? _address;
  final String? _email;
  final String? _name;
  final String? _phone;

  CustomerAddress get address {
    try {
      return _address!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get name {
    return _name;
  }
  
  String? get phone {
    return _phone;
  }
  
  const StripeBillingDetails._internal({required address, required email, name, phone}): _address = address, _email = email, _name = name, _phone = phone;
  
  factory StripeBillingDetails({required CustomerAddress address, required String email, String? name, String? phone}) {
    return StripeBillingDetails._internal(
      address: address,
      email: email,
      name: name,
      phone: phone);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StripeBillingDetails &&
      _address == other._address &&
      _email == other._email &&
      _name == other._name &&
      _phone == other._phone;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("StripeBillingDetails {");
    buffer.write("address=" + (_address != null ? _address!.toString() : "null") + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("phone=" + "$_phone");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  StripeBillingDetails copyWith({CustomerAddress? address, String? email, String? name, String? phone}) {
    return StripeBillingDetails._internal(
      address: address ?? this.address,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone);
  }
  
  StripeBillingDetails copyWithModelFieldValues({
    ModelFieldValue<CustomerAddress>? address,
    ModelFieldValue<String>? email,
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? phone
  }) {
    return StripeBillingDetails._internal(
      address: address == null ? this.address : address.value,
      email: email == null ? this.email : email.value,
      name: name == null ? this.name : name.value,
      phone: phone == null ? this.phone : phone.value
    );
  }
  
  StripeBillingDetails.fromJson(Map<String, dynamic> json)  
    : _address = json['address'] != null
          ? json['address']['serializedData'] != null
              ? CustomerAddress.fromJson(new Map<String, dynamic>.from(json['address']['serializedData']))
              : CustomerAddress.fromJson(new Map<String, dynamic>.from(json['address']))
        : null,
      _email = json['email'],
      _name = json['name'],
      _phone = json['phone'];
  
  Map<String, dynamic> toJson() => {
    'address': _address?.toJson(), 'email': _email, 'name': _name, 'phone': _phone
  };
  
  Map<String, Object?> toMap() => {
    'address': _address,
    'email': _email,
    'name': _name,
    'phone': _phone
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "StripeBillingDetails";
    modelSchemaDefinition.pluralName = "StripeBillingDetails";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'address',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'CustomerAddress')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'email',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'name',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'phone',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}