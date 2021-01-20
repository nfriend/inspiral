import { ImageInfo } from './image_info';
import path from 'path';

interface CircleGearParams {
  toothCount: number;
}

export const generateCircleGear = async ({
  toothCount,
}: CircleGearParams): Promise<ImageInfo> => {
  return {
    htmlInputFilePath: path.resolve(__dirname, '../tmp', 'gear_24.html'),
    pngOutputFilePath: path.resolve(__dirname, '../tmp', 'gear_24.png'),
  };
};
