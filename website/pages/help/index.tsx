import HelpCustomHead from './help-custom-head';
import VersionIndicator from './version-indicator';

export default function Home() {
  return (
    <div className="help p-5 sm:p-10 flex justify-center font-sans">
      <HelpCustomHead />

      <div className="max-w-xl pb-10">
        <h2 id="table-of-contents">Table of contents</h2>

        <ul>
          <li>
            <a href="#what-does-this-button-do">What does this button do?</a>
          </li>
          <li>
            <a href="#selecting-a-new-pen-hole">Selecting a new pen hole</a>
          </li>
          <li>
            <a href="#rotating-the-gear-in-place">Rotating the gear in place</a>
          </li>
          <li>
            <a href="#using-auto-draw">Using auto-draw</a>
          </li>
          <li>
            <a href="#locking-the-fixed-gear">Locking the fixed gear</a>
          </li>
          <li>
            <a href="#rotating-the-fixed-gear">Rotating the fixed gear</a>
          </li>
          <li>
            <a href="#using-fixed-gear-snap-points">
              Using fixed gear "snap points"
            </a>
          </li>
          <li>
            <a href="#restoring-purchases">Restoring purchases</a>
          </li>
          <li>
            <a href="#saving-pictures-to-the-gallery">
              Saving pictures to the gallery
            </a>
          </li>
          <li>
            <a href="#where-do-pictures-go-when-they-are-saved">
              Where do pictures go when they are saved?
            </a>
          </li>
          <li>
            <a href="#fixing-mistakes-with-undo-redo">
              Fixing mistakes with undo/redo
            </a>
          </li>
        </ul>

        <h3 id="what-does-this-button-do">What does this button do?</h3>

        <p>
          If you're unsure what a button does, press and hold on the button to
          reveal a tooltip:
        </p>

        <img
          src="/help/images/tooltip.gif"
          alt="A GIF showing how to reveal a tooltip on a button"
        />

        <h3 id="selecting-a-new-pen-hole">Selecting a new pen hole</h3>

        <p>
          You can select a different hole by opening the <b>Tools</b> tab and
          pressing the first button in the top row. This will zoom in on the
          rotating gear and allow you to select any of the available holes.
          Press the button again to zoom back out.
        </p>

        <img
          src="/help/images/select-hole-button.png"
          alt="A screenshot of the 'Select hole' button"
        />

        <h3 id="rotating-the-gear-in-place">Rotating the gear in place</h3>

        <p>
          To draw a pattern multiple times with each pattern offset by a single
          tooth, press the second or third buttons in the <b>Tools</b> tab.
          These buttons rotate the gear in place by a single tooth, without
          drawing any lines.
        </p>

        <img
          src="/help/images/rotate-in-place.png"
          alt="A screenshot of the 'Rotate by one tooth' buttons"
        />

        <h3 id="using-auto-draw">Using auto-draw</h3>

        <p>
          Instead of dragging the gear yourself, you can let Inspiral do the
          hard work for you! The fourth button in the <b>Tools</b> tab will spin
          the rotating gear one full rotation (360°). The fifth button will spin
          until a complete pattern is drawn and the pen is back in its original
          position.
        </p>

        <img
          src="/help/images/auto-draw.png"
          alt="A screenshot of the 'Auto draw' buttons"
        />

        <p>
          To make auto-draw faster, open the <b>Additional options</b> sidebar
          and set the <b>Auto-draw speed</b> setting to "Fast".
        </p>

        <h3 id="locking-the-fixed-gear">Locking the fixed gear</h3>

        <p>
          To avoid accidentally moving the fixed gear, press the button with the
          lock icon in the <b>Tools</b> tab. This will lock the fixed gear in
          place, and you will no longer be able to move or rotate it. To unlock
          the gear, press the button again.
        </p>

        <img
          src="/help/images/fixed-gear-lock.png"
          alt="A screenshot of the 'Lock fixed gear' button"
        />

        <h3 id="rotating-the-fixed-gear">Rotating the fixed gear</h3>

        <p>
          The fixed gear can be rotated using a two-finger gesture. Note that
          both fingers must be touching the fixed gear. For small gears, it may
          help to zoom in on the gear before attempting to rotate it.
        </p>

        <h3 id="using-fixed-gear-snap-points">
          Using fixed gear "snap points"
          <VersionIndicator version="1.1.0" />
        </h3>

        <p>
          When you begin moving the rotating gear, a small blue "snap point" is
          added to the canvas.
        </p>

        <img
          src="/help/images/snap-point.jpg"
          alt="A gear with a 'snap point' at its center"
        />

        <p>
          While moving the fixed gear around the canvas, the fixed gear will
          "snap" to these points to allow for perfect alignment with previous
          drawings.
        </p>

        <p>
          To turn snap points on or off, press the final button in the{' '}
          <b>Tools</b> tab.
        </p>

        <img
          src="/help/images/snap-points-button.png"
          alt="A screenshot of the 'Snap points' toggle button"
        />

        <h3 id="restoring-purchases">Restoring purchases</h3>

        <p>
          If you purchase premium features and then uninstall/reinstall the app
          - or if you install the app on a second device - you will need to
          click the <b>Restore purchases</b> button in the{' '}
          <b>Additional options</b> sidebar in order to unlock the features you
          have purchased.
        </p>

        <img
          src="/help/images/restore-purchases.png"
          alt="A screenshot of the 'Restore purchases' button"
        />

        <p>
          Please note that purchases cannot be shared across platforms. If you
          purchase the item on an iOS device, the item will not be available on
          Android devices, and vice-versa.
        </p>

        <h3 id="saving-pictures-to-the-gallery">
          Saving pictures to the gallery
        </h3>

        <p>
          To save your masterpiece, click the <b>Save</b> icon in the menu bar.
        </p>

        <img
          src="/help/images/save-icon.jpg"
          alt="A screenshot of the 'Save' icon"
        />

        <p>
          This will open a screen that will allow you to crop and/or rotate your
          picture.
        </p>

        <p>
          <b>On iOS</b>, press the <b>Done</b> button to save your picture.
        </p>

        <p>
          <b>On Android</b>, press the checkmark icon to save your picture.
        </p>

        <h3 id="where-do-pictures-go-when-they-are-saved">
          Where do pictures go when they are saved?
        </h3>

        <p>
          <b>On iOS</b>, pictures are saved to the Photos app.
        </p>

        <p>
          <b>On Android</b>, pictures are saved to a "Pictures" folder on your
          device. If you are using Google Photos, this folder can be accessed on
          the <b>Photos on device</b> screen.
        </p>

        <h3 id="fixing-mistakes-with-undo-redo">
          Fixing mistakes with undo/redo
          <VersionIndicator version="1.2.1" />
        </h3>

        <p>
          If you make a mistake, don't worry! Press the undo button in the menu
          bar to step backwards in time:
        </p>

        <img
          src="/help/images/undo-icon.jpg"
          alt="A screenshot of the 'Undo' icon"
        />

        <p>
          If you change your mind, use the redo button to step forwards in time.
          On large screens, this option can be found next to the undo button in
          the menu bar. On small screens, this option can be found in the{' '}
          <b>Additional options</b> sidebar.
        </p>

        <p>Undo and redo only affect certain features:</p>

        <ul>
          <li>Drawn lines</li>
          <li>Gear selections and positions</li>
          <li>
            <a href="#selecting-a-new-pen-hole">Pen hole</a>, color, and style
          </li>
          <li>Canvas color</li>
          <li>
            <a href="#using-fixed-gear-snap-points">Snap points</a>
          </li>
        </ul>
      </div>

      {/* https://github.com/bryanbraun/anchorjs */}
      <script src="https://cdn.jsdelivr.net/npm/anchor-js/anchor.min.js"></script>
      <script>anchors.add();</script>
    </div>
  );
}
