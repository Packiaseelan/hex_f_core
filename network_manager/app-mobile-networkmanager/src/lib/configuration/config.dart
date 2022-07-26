import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

/// Global network configuration model
@JsonSerializable()
class Config {
  final String? baseURL;
  final List<Environment> restEnvironments;
  final List<Environment> gqlEnvironments;
  final Map<String, String> gqlMappingOverrides;
  final Map<String, String> headers;
  final bool? useMockNetworkClient;

  Config(
    this.baseURL,
    this.restEnvironments,
    this.gqlEnvironments,
    this.gqlMappingOverrides,
    this.headers,
    this.useMockNetworkClient,
  );

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

/// Information pertaining to each environment.
@JsonSerializable()
class Environment {
  Environment(this.name, this.host, this.headers);

  final String name;
  final String host;

  final Map<String, String>? headers;

  factory Environment.fromJson(Map<String, dynamic> json) => _$EnvironmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}
