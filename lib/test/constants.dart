import 'package:uptime/models/ModelProvider.dart';

Device perfecto = Device(
    id: "",
    serialNumber: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Perfecto",
    runCurrent: 2,
    idleCurrent: 0.5,
    targetUptime: 0.9);

Device downBoy = Device(
    id: "",
    serialNumber: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Bobby",
    runCurrent: 4,
    idleCurrent: 2,
    targetUptime: 0.9);

Device upMan = Device(
    id: "",
    serialNumber: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Goodboy",
    runCurrent: 3,
    idleCurrent: 1,
    targetUptime: 0.9);

Device upMon = Device(
    id: "",
    serialNumber: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Goodish",
    runCurrent: 3,
    idleCurrent: 1.5,
    targetUptime: 0.8);

Device upOne = Device(
    id: "",
    serialNumber: "",
    process: "Subtraction",
    hourlyValue: 50,
    cycleTime: 20,
    active: true,
    name: "Goodest",
    runCurrent: 1,
    idleCurrent: 0.5,
    targetUptime: 0.9);

Device beast = Device(
    id: "",
    serialNumber: "",
    process: "Subtraction",
    hourlyValue: 50,
    cycleTime: 2,
    active: true,
    name: "Beast",
    runCurrent: 4,
    idleCurrent: 1.0,
    targetUptime: 0.9);

List<Device> allDevices = [
  perfecto,
  downBoy,
  upMan,
  upMon,
  upOne,
  beast,
];
