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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the User type in your schema. */
class User extends amplify_core.Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _authId;
  final StripeBillingDetails? _billingDetails;
  final String? _division;
  final String? _location;
  final List<Device>? _devices;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String get authId {
    try {
      return _authId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  StripeBillingDetails? get billingDetails {
    return _billingDetails;
  }
  
  String? get division {
    return _division;
  }
  
  String? get location {
    return _location;
  }
  
  List<Device>? get devices {
    return _devices;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required authId, billingDetails, division, location, devices, createdAt, updatedAt}): _authId = authId, _billingDetails = billingDetails, _division = division, _location = location, _devices = devices, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String authId, StripeBillingDetails? billingDetails, String? division, String? location, List<Device>? devices}) {
    return User._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      authId: authId,
      billingDetails: billingDetails,
      division: division,
      location: location,
      devices: devices != null ? List<Device>.unmodifiable(devices) : devices);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _authId == other._authId &&
      _billingDetails == other._billingDetails &&
      _division == other._division &&
      _location == other._location &&
      DeepCollectionEquality().equals(_devices, other._devices);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("authId=" + "$_authId" + ", ");
    buffer.write("billingDetails=" + (_billingDetails != null ? _billingDetails!.toString() : "null") + ", ");
    buffer.write("division=" + "$_division" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? authId, StripeBillingDetails? billingDetails, String? division, String? location, List<Device>? devices}) {
    return User._internal(
      id: id,
      authId: authId ?? this.authId,
      billingDetails: billingDetails ?? this.billingDetails,
      division: division ?? this.division,
      location: location ?? this.location,
      devices: devices ?? this.devices);
  }
  
  User copyWithModelFieldValues({
    ModelFieldValue<String>? authId,
    ModelFieldValue<StripeBillingDetails?>? billingDetails,
    ModelFieldValue<String?>? division,
    ModelFieldValue<String?>? location,
    ModelFieldValue<List<Device>?>? devices
  }) {
    return User._internal(
      id: id,
      authId: authId == null ? this.authId : authId.value,
      billingDetails: billingDetails == null ? this.billingDetails : billingDetails.value,
      division: division == null ? this.division : division.value,
      location: location == null ? this.location : location.value,
      devices: devices == null ? this.devices : devices.value
    );
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _authId = json['authId'],
      _billingDetails = json['billingDetails'] != null
          ? json['billingDetails']['serializedData'] != null
              ? StripeBillingDetails.fromJson(new Map<String, dynamic>.from(json['billingDetails']['serializedData']))
              : StripeBillingDetails.fromJson(new Map<String, dynamic>.from(json['billingDetails']))
        : null,
      _division = json['division'],
      _location = json['location'],
      _devices = json['devices']  is Map
        ? (json['devices']['items'] is List
          ? (json['devices']['items'] as List)
              .where((e) => e != null)
              .map((e) => Device.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['devices'] is List
          ? (json['devices'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Device.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'authId': _authId, 'billingDetails': _billingDetails?.toJson(), 'division': _division, 'location': _location, 'devices': _devices?.map((Device? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'authId': _authId,
    'billingDetails': _billingDetails,
    'division': _division,
    'location': _location,
    'devices': _devices,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UserModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final AUTHID = amplify_core.QueryField(fieldName: "authId");
  static final BILLINGDETAILS = amplify_core.QueryField(fieldName: "billingDetails");
  static final DIVISION = amplify_core.QueryField(fieldName: "division");
  static final LOCATION = amplify_core.QueryField(fieldName: "location");
  static final DEVICES = amplify_core.QueryField(
    fieldName: "devices",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Device'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.AUTHID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'billingDetails',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'StripeBillingDetails')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.DIVISION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.LOCATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.DEVICES,
      isRequired: false,
      ofModelName: 'Device',
      associatedKey: Device.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends amplify_core.ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
class UserModelIdentifier implements amplify_core.ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}