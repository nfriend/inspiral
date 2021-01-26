import fs from 'fs';
import util from 'util';
import path from 'path';
import ejs from 'ejs';
import camelCase from 'camelcase';
import { GearDefinition } from '../models/gear_definition';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

/**
 * Writes a TypeScript gear definition to a *.dart file
 * that will instantiate a Dart version of the gear definition
 * when the Flutter app is run.
 *
 * @param gearDefinition The gear definition to write
 * @returns A Dart "export" statement to this file that should
 * be included in the main `gears.dart` proxy export file.
 */
export const writeGearDefinitionAsDartFile = async (
  gearDefinition: GearDefinition,
  filePath: string,
): Promise<void> => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/dart_gear_definition.ejs',
  );

  const camelCasedGearName = camelCase(gearDefinition.gearName);

  const rendered = await renderFile(templateFilePath, {
    gearDefinition,
    camelCasedGearName,
  });

  await writeFile(filePath, rendered);
};
