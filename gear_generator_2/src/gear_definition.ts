import fs from 'fs';
import util from 'util';
import camelCase from 'camelcase';
import { ContactPoint } from './contact_point';

const writeFile = util.promisify(fs.writeFile);

/**
 * A class that holds all the data necessary to
 * instantiate a Dart `GearDefinition` class
 * (lib/models/gear_definition.dart).
 */
export interface GearDefinition {
  /** The name of this gear */
  gearName: string;

  /** The asset path to the gear's image */
  image: string;

  /** The size of the gear, in logical pixels */
  size: {
    width: number;
    height: number;
  };

  /** The number of teeth on this gear */
  toothCount: number;

  /** The points that define the shape of this gear */
  points: ContactPoint[];
}

/**
 * Writes a TypeScript gear definition to a *.dart file
 * that will instantiate a Dart version of the gear definition
 * when the Flutter app is run.
 * @param gearDefinition The gear definition to write
 * @returns A Dart "export" statement to this file that should
 * be included in the main `gears.dart` proxy export file.
 */
export const writeAsDartGearDefinitionInstance = async (
  gearDefinition: GearDefinition,
  filePath: string,
): Promise<string> => {
  const contents: string[] = [];

  contents.push(`// THIS FILE IS AUTO-GENERATED
// ---------------------------
//
// Do not edit by hand.
//
// This file is generated by the Node application
// in the \`gear_generator_2\` directory.`);

  contents.push('');

  contents.push("import 'dart:ui';");
  contents.push("import 'package:inspiral/models/contact_point.dart';");
  contents.push("import 'package:inspiral/models/gear_definition.dart';");

  contents.push('');

  contents.push(
    `final ${camelCase(gearDefinition.gearName)} = GearDefinition(`,
  );
  contents.push(`    image: '${gearDefinition.image}',`);
  contents.push(
    `    size: Size(${gearDefinition.size.width}, ${gearDefinition.size.height}),`,
  );
  contents.push(`    toothCount: ${gearDefinition.toothCount},`);
  contents.push(`    points: [`);

  for (const point of gearDefinition.points) {
    contents.push(`      ContactPoint(`);
    contents.push(
      `          position: Offset(${point.position.x}, ${point.position.y}),`,
    );
    contents.push(`          direction: ${point.direction}),`);
  }

  contents.push(`    ]);`);

  contents.push('');

  await writeFile(filePath, contents.join('\n'));

  return `export 'package:inspiral/models/gears/${gearDefinition.gearName}.dart';`;
};

/**
 * Writes the `gears.dart` file, which contains proxy exports
 * for all the gears generated by the `writeAsDartGearDefinitionInstance`
 * function.
 *
 * @param exports The list of export statements to write
 */
export const writeDartProxyExportFile = async (
  exports: string[],
  filePath: string,
): Promise<void> => {
  const contents: string[] = [];

  contents.push(`// THIS FILE IS AUTO-GENERATED
// ---------------------------
//
// Do not edit by hand.
//
// This file is generated by the Node application
// in the \`gear_generator_2\` directory.`);

  contents.push('');

  for (const ex of exports) {
    contents.push(ex);
  }

  contents.push('');

  await writeFile(filePath, contents.join('\n'));
};
