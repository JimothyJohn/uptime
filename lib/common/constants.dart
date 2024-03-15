import 'package:visuals/common/models.dart';
import 'package:visuals/common/utils.dart';

const Machine perfecto = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Perfecto",
    runCurrent: 2,
    idleCurrent: 0.5,
    targetUptime: 0.9);

const Machine downBoy = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Bobby",
    runCurrent: 4,
    idleCurrent: 2,
    targetUptime: 0.9);

const Machine upMan = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Goodboy",
    runCurrent: 3,
    idleCurrent: 1,
    targetUptime: 0.9);

const Machine upMon = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Goodish",
    runCurrent: 3,
    idleCurrent: 1.5,
    targetUptime: 0.8);

const Machine upOne = Machine(
    id: "",
    process: "Subtraction",
    hourlyValue: 50,
    cycleTime: 20,
    active: true,
    name: "Goodest",
    runCurrent: 1,
    idleCurrent: 0.5,
    targetUptime: 0.9);

const Machine beast = Machine(
    id: "",
    process: "Subtraction",
    hourlyValue: 50,
    cycleTime: 2,
    active: true,
    name: "Beast",
    runCurrent: 4,
    idleCurrent: 1.0,
    targetUptime: 0.9);

const List<Machine> allMachines = [
  perfecto,
  downBoy,
  upMan,
  upMon,
  upOne,
  beast,
];

Map<Machine, List<Measurement>> dayMeasurementMap =
    createMachineMeasurementsMap(allMachines, [
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
]);

Map<Machine, List<Measurement>> weekMeasurementMap =
    createMachineMeasurementsMap(allMachines, [
  generateWeekMeasurements(),
  generateWeekMeasurements(),
  generateWeekMeasurements(),
  generateWeekMeasurements(),
  generateWeekMeasurements(),
  generateWeekMeasurements(),
  generateWeekMeasurements(),
]);

Map<Machine, List<Measurement>> monthMeasurementMap =
    createMachineMeasurementsMap(allMachines, [
  generateMonthMeasurements(),
  generateMonthMeasurements(),
  generateMonthMeasurements(),
  generateMonthMeasurements(),
  generateMonthMeasurements(),
  generateMonthMeasurements(),
  generateMonthMeasurements(),
]);
