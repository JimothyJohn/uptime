class Measurement {
  final DateTime time;
  final double value;

  const Measurement({required this.time, required this.value});
}

class Machine {
  final String id;
  final String name;
  final double hourlyValue;
  final String? manufacturer;
  final String? model;
  final String? process;
  final double cycleTime;
  final bool active;
  final double runCurrent;
  final double idleCurrent;
  final double targetUptime;
  final String? division;
  final String? location;
  final String? subscriptionItem;
  final String?
      userId; // Assuming you will handle the user as a separate entity
  final String?
      organizationId; // Assuming you will handle the organization as a separate entity

  const Machine({
    required this.id,
    required this.name,
    required this.hourlyValue,
    this.manufacturer,
    this.model,
    this.process,
    required this.cycleTime,
    required this.active,
    required this.runCurrent,
    required this.idleCurrent,
    required this.targetUptime,
    this.division,
    this.location,
    this.subscriptionItem,
    this.userId,
    this.organizationId,
  });

  // You might want to include fromJson and toJson methods to serialize and deserialize your objects
  // especially if you're planning to store them locally or send/receive them from a backend service.

  // Example toJson method
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'hourlyValue': hourlyValue,
        'manufacturer': manufacturer,
        'model': model,
        'process': process,
        'cycleTime': cycleTime,
        'active': active,
        'runCurrent': runCurrent,
        'idleCurrent': idleCurrent,
        'targetUptime': targetUptime,
        'division': division,
        'location': location,
        'subscriptionItem': subscriptionItem,
        'userId': userId,
        'organizationId': organizationId,
      };

  // Example fromJson method
  factory Machine.fromJson(Map<String, dynamic> json) => Machine(
        id: json['id'],
        name: json['name'],
        hourlyValue: json['hourlyValue'].toDouble(),
        manufacturer: json['manufacturer'],
        model: json['model'],
        process: json['process'],
        cycleTime: json['cycleTime'].toDouble(),
        active: json['active'],
        runCurrent: json['runCurrent'].toDouble(),
        idleCurrent: json['idleCurrent'].toDouble(),
        targetUptime: json['targetUptime'].toDouble(),
        division: json['division'],
        location: json['location'],
        subscriptionItem: json['subscriptionItem'],
        userId: json['userId'],
        organizationId: json['organizationId'],
      );
}
