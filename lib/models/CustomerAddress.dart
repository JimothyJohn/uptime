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


/** This is an auto generated class representing the CustomerAddress type in your schema. */
class CustomerAddress {
  final String? _line1;
  final String? _line2;
  final String? _city;
  final String? _state;
  final String? _postal_code;
  final String? _country;

  String? get line1 {
    return _line1;
  }
  
  String? get line2 {
    return _line2;
  }
  
  String? get city {
    return _city;
  }
  
  String? get state {
    return _state;
  }
  
  String? get postal_code {
    return _postal_code;
  }
  
  String? get country {
    return _country;
  }
  
  const CustomerAddress._internal({line1, line2, city, state, postal_code, country}): _line1 = line1, _line2 = line2, _city = city, _state = state, _postal_code = postal_code, _country = country;
  
  factory CustomerAddress({String? line1, String? line2, String? city, String? state, String? postal_code, String? country}) {
    return CustomerAddress._internal(
      line1: line1,
      line2: line2,
      city: city,
      state: state,
      postal_code: postal_code,
      country: country);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomerAddress &&
      _line1 == other._line1 &&
      _line2 == other._line2 &&
      _city == other._city &&
      _state == other._state &&
      _postal_code == other._postal_code &&
      _country == other._country;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CustomerAddress {");
    buffer.write("line1=" + "$_line1" + ", ");
    buffer.write("line2=" + "$_line2" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("postal_code=" + "$_postal_code" + ", ");
    buffer.write("country=" + "$_country");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CustomerAddress copyWith({String? line1, String? line2, String? city, String? state, String? postal_code, String? country}) {
    return CustomerAddress._internal(
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      state: state ?? this.state,
      postal_code: postal_code ?? this.postal_code,
      country: country ?? this.country);
  }
  
  CustomerAddress copyWithModelFieldValues({
    ModelFieldValue<String?>? line1,
    ModelFieldValue<String?>? line2,
    ModelFieldValue<String?>? city,
    ModelFieldValue<String?>? state,
    ModelFieldValue<String?>? postal_code,
    ModelFieldValue<String?>? country
  }) {
    return CustomerAddress._internal(
      line1: line1 == null ? this.line1 : line1.value,
      line2: line2 == null ? this.line2 : line2.value,
      city: city == null ? this.city : city.value,
      state: state == null ? this.state : state.value,
      postal_code: postal_code == null ? this.postal_code : postal_code.value,
      country: country == null ? this.country : country.value
    );
  }
  
  CustomerAddress.fromJson(Map<String, dynamic> json)  
    : _line1 = json['line1'],
      _line2 = json['line2'],
      _city = json['city'],
      _state = json['state'],
      _postal_code = json['postal_code'],
      _country = json['country'];
  
  Map<String, dynamic> toJson() => {
    'line1': _line1, 'line2': _line2, 'city': _city, 'state': _state, 'postal_code': _postal_code, 'country': _country
  };
  
  Map<String, Object?> toMap() => {
    'line1': _line1,
    'line2': _line2,
    'city': _city,
    'state': _state,
    'postal_code': _postal_code,
    'country': _country
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CustomerAddress";
    modelSchemaDefinition.pluralName = "CustomerAddresses";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'line1',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'line2',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'city',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'state',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'postal_code',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'country',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}