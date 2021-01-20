import { GearPath } from './gear_path';
import { create } from 'xmlbuilder2';

interface GearSvgConstructorParams {
  path: GearPath;
  width: number;
  height: number;
}

export class GearSvg {
  public params;

  constructor(params: GearSvgConstructorParams) {
    this.params = params;
  }
}

GearSvg.prototype.toString = function (): string {
  return create()
    .ele({
      'svg@http://www.w3.org/2000/svg': {
        '@version': '1.1',
        '@width': this.params.width,
        '@height': this.params.height,
        '@viewbox': `0 0 ${this.params.width} ${this.params.height}`,
        g: {
          path: {
            '@d': this.params.path.toString(),
            '@style':
              'fill:#000000; fill-opacity:0.3; stroke:#000000; stroke-width:0.25;',
          },
        },
      },
    })
    .end({ prettyPrint: true });
};
