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


/** This is an auto generated class representing the Device type in your schema. */
class Device extends amplify_core.Model {
  static const classType = const _DeviceModelType();
  final String id;
  final String? _name;
  final double? _hourlyValue;
  final String? _serialNumber;
  final String? _manufacturer;
  final String? _model;
  final String? _process;
  final double? _cycleTime;
  final bool? _active;
  final double? _runCurrent;
  final double? _idleCurrent;
  final double? _targetUptime;
  final String? _division;
  final String? _location;
  final User? _user;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  DeviceModelIdentifier get modelIdentifier {
      return DeviceModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get hourlyValue {
    try {
      return _hourlyValue!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get serialNumber {
    try {
      return _serialNumber!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get manufacturer {
    return _manufacturer;
  }
  
  String? get model {
    return _model;
  }
  
  String? get process {
    return _process;
  }
  
  double? get cycleTime {
    return _cycleTime;
  }
  
  bool get active {
    try {
      return _active!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double? get runCurrent {
    return _runCurrent;
  }
  
  double? get idleCurrent {
    return _idleCurrent;
  }
  
  double? get targetUptime {
    return _targetUptime;
  }
  
  String? get division {
    return _division;
  }
  
  String? get location {
    return _location;
  }
  
  User? get user {
    return _user;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Device._internal({required this.id, required name, required hourlyValue, required serialNumber, manufacturer, model, process, cycleTime, required active, runCurrent, idleCurrent, targetUptime, division, location, user, createdAt, updatedAt}): _name = name, _hourlyValue = hourlyValue, _serialNumber = serialNumber, _manufacturer = manufacturer, _model = model, _process = process, _cycleTime = cycleTime, _active = active, _runCurrent = runCurrent, _idleCurrent = idleCurrent, _targetUptime = targetUptime, _division = division, _location = location, _user = user, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Device({String? id, required String name, required double hourlyValue, required String serialNumber, String? manufacturer, String? model, String? process, double? cycleTime, required bool active, double? runCurrent, double? idleCurrent, double? targetUptime, String? division, String? location, User? user}) {
    return Device._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      hourlyValue: hourlyValue,
      serialNumber: serialNumber,
      manufacturer: manufacturer,
      model: model,
      process: process,
      cycleTime: cycleTime,
      active: active,
      runCurrent: runCurrent,
      idleCurrent: idleCurrent,
      targetUptime: targetUptime,
      division: division,
      location: location,
      user: user);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Device &&
      id == other.id &&
      _name == other._name &&
      _hourlyValue == other._hourlyValue &&
      _serialNumber == other._serialNumber &&
      _manufacturer == other._manufacturer &&
      _model == other._model &&
      _process == other._process &&
      _cycleTime == other._cycleTime &&
      _active == other._active &&
      _runCurrent == other._runCurrent &&
      _idleCurrent == other._idleCurrent &&
      _targetUptime == other._targetUptime &&
      _division == other._division &&
      _location == other._location &&
      _user == other._user;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Device {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("hourlyValue=" + (_hourlyValue != null ? _hourlyValue!.toString() : "null") + ", ");
    buffer.write("serialNumber=" + "$_serialNumber" + ", ");
    buffer.write("manufacturer=" + "$_manufacturer" + ", ");
    buffer.write("model=" + "$_model" + ", ");
    buffer.write("process=" + "$_process" + ", ");
    buffer.write("cycleTime=" + (_cycleTime != null ? _cycleTime!.toString() : "null") + ", ");
    buffer.write("active=" + (_active != null ? _active!.toString() : "null") + ", ");
    buffer.write("runCurrent=" + (_runCurrent != null ? _runCurrent!.toString() : "null") + ", ");
    buffer.write("idleCurrent=" + (_idleCurrent != null ? _idleCurrent!.toString() : "null") + ", ");
    buffer.write("targetUptime=" + (_targetUptime != null ? _targetUptime!.toString() : "null") + ", ");
    buffer.write("division=" + "$_division" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Device copyWith({String? name, double? hourlyValue, String? serialNumber, String? manufacturer, String? model, String? process, double? cycleTime, bool? active, double? runCurrent, double? idleCurrent, double? targetUptime, String? division, String? location, User? user}) {
    return Device._internal(
      id: id,
      name: name ?? this.name,
      hourlyValue: hourlyValue ?? this.hourlyValue,
      serialNumber: serialNumber ?? this.serialNumber,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      process: process ?? this.process,
      cycleTime: cycleTime ?? this.cycleTime,
      active: active ?? this.active,
      runCurrent: runCurrent ?? this.runCurrent,
      idleCurrent: idleCurrent ?? this.idleCurrent,
      targetUptime: targetUptime ?? this.targetUptime,
      division: division ?? this.division,
      location: location ?? this.location,
      user: user ?? this.user);
  }
  
  Device copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<double>? hourlyValue,
    ModelFieldValue<String>? serialNumber,
    ModelFieldValue<String?>? manufacturer,
    ModelFieldValue<String?>? model,
    ModelFieldValue<String?>? process,
    ModelFieldValue<double?>? cycleTime,
    ModelFieldValue<bool>? active,
    ModelFieldValue<double?>? runCurrent,
    ModelFieldValue<double?>? idleCurrent,
    ModelFieldValue<double?>? targetUptime,
    ModelFieldValue<String?>? division,
    ModelFieldValue<String?>? location,
    ModelFieldValue<User?>? user
  }) {
    return Device._internal(
      id: id,
      name: name == null ? this.name : name.value,
      hourlyValue: hourlyValue == null ? this.hourlyValue : hourlyValue.value,
      serialNumber: serialNumber == null ? this.serialNumber : serialNumber.value,
      manufacturer: manufacturer == null ? this.manufacturer : manufacturer.value,
      model: model == null ? this.model : model.value,
      process: process == null ? this.process : process.value,
      cycleTime: cycleTime == null ? this.cycleTime : cycleTime.value,
      active: active == null ? this.active : active.value,
      runCurrent: runCurrent == null ? this.runCurrent : runCurrent.value,
      idleCurrent: idleCurrent == null ? this.idleCurrent : idleCurrent.value,
      targetUptime: targetUptime == null ? this.targetUptime : targetUptime.value,
      division: division == null ? this.division : division.value,
      location: location == null ? this.location : location.value,
      user: user == null ? this.user : user.value
    );
  }
  
  Device.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _hourlyValue = (json['hourlyValue'] as num?)?.toDouble(),
      _serialNumber = json['serialNumber'],
      _manufacturer = json['manufacturer'],
      _model = json['model'],
      _process = json['process'],
      _cycleTime = (json['cycleTime'] as num?)?.toDouble(),
      _active = json['active'],
      _runCurrent = (json['runCurrent'] as num?)?.toDouble(),
      _idleCurrent = (json['idleCurrent'] as num?)?.toDouble(),
      _targetUptime = (json['targetUptime'] as num?)?.toDouble(),
      _division = json['division'],
      _location = json['location'],
      _user = json['user'] != null
        ? json['user']['serializedData'] != null
          ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
          : User.fromJson(new Map<String, dynamic>.from(json['user']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'hourlyValue': _hourlyValue, 'serialNumber': _serialNumber, 'manufacturer': _manufacturer, 'model': _model, 'process': _process, 'cycleTime': _cycleTime, 'active': _active, 'runCurrent': _runCurrent, 'idleCurrent': _idleCurrent, 'targetUptime': _targetUptime, 'division': _division, 'location': _location, 'user': _user?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'hourlyValue': _hourlyValue,
    'serialNumber': _serialNumber,
    'manufacturer': _manufacturer,
    'model': _model,
    'process': _process,
    'cycleTime': _cycleTime,
    'active': _active,
    'runCurrent': _runCurrent,
    'idleCurrent': _idleCurrent,
    'targetUptime': _targetUptime,
    'division': _division,
    'location': _location,
    'user': _user,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<DeviceModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<DeviceModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final HOURLYVALUE = amplify_core.QueryField(fieldName: "hourlyValue");
  static final SERIALNUMBER = amplify_core.QueryField(fieldName: "serialNumber");
  static final MANUFACTURER = amplify_core.QueryField(fieldName: "manufacturer");
  static final MODEL = amplify_core.QueryField(fieldName: "model");
  static final PROCESS = amplify_core.QueryField(fieldName: "process");
  static final CYCLETIME = amplify_core.QueryField(fieldName: "cycleTime");
  static final ACTIVE = amplify_core.QueryField(fieldName: "active");
  static final RUNCURRENT = amplify_core.QueryField(fieldName: "runCurrent");
  static final IDLECURRENT = amplify_core.QueryField(fieldName: "idleCurrent");
  static final TARGETUPTIME = amplify_core.QueryField(fieldName: "targetUptime");
  static final DIVISION = amplify_core.QueryField(fieldName: "division");
  static final LOCATION = amplify_core.QueryField(fieldName: "location");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Device";
    modelSchemaDefinition.pluralName = "Devices";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.HOURLYVALUE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.SERIALNUMBER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.MANUFACTURER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.MODEL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.PROCESS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.CYCLETIME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.ACTIVE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.RUNCURRENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.IDLECURRENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.TARGETUPTIME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.DIVISION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Device.LOCATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Device.USER,
      isRequired: false,
      targetNames: ['userDevicesId'],
      ofModelName: 'User'
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

class _DeviceModelType extends amplify_core.ModelType<Device> {
  const _DeviceModelType();
  
  @override
  Device fromJson(Map<String, dynamic> jsonData) {
    return Device.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Device';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Device] in your schema.
 */
class DeviceModelIdentifier implements amplify_core.ModelIdentifier<Device> {
  final String id;

  /** Create an instance of DeviceModelIdentifier using [id] the primary key. */
  const DeviceModelIdentifier({
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
  String toString() => 'DeviceModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is DeviceModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}