import HelpCustomHead from './help-custom-head';

export default function Home() {
  return (
    <div className="help p-10 flex justify-center font-sans">
      <HelpCustomHead />

      <div className="max-w-xl pb-10">
        <div className="alert alert-info">
          <p>
            <b>Welcome to the Inspiral app's documentation!</b>
          </p>

          <p>
            This content is a work-in-progress and is not complete, but will
            hopefully answer some of the most common questions.
          </p>
        </div>

        <h1>Table of contents</h1>

        <ul className="list-disc list-inside">
          <li>
            <a href="#what-does-this-button-do">What does this button do?</a>
          </li>
          <li>
            <a href="#selecting-a-new-pen-hole">Selecting a new pen hole</a>
          </li>
          <li>
            <a href="#restoring-purchases">Restoring purchases</a>
          </li>
          <li>
            <a href="#saving-pictures-to-the-gallery">
              Saving pictures to the gallery
            </a>
          </li>
        </ul>

        <h2 id="what-does-this-button-do">What does this button do?</h2>

        <p>
          If you're unsure what a button does, press and hold on the button to
          reveal a tooltip:
        </p>

        <img
          src="/help/images/tooltip.gif"
          alt="A GIF showing how to reveal a tooltip on a button"
        />

        <h2 id="selecting-a-new-pen-hole">Selecting a new pen hole</h2>

        <p>
          You can select a different hole by opening the "Tools" tab and
          pressing the first button in the top row. This will zoom in on the
          rotating gear and allow you to select any of the available holes.
          Press the button again to zoom back out.
        </p>

        <img
          src="/help/images/select-hole-button.png"
          alt="A screenshot of the 'Select hole' button"
        />

        <h2 id="restoring-purchases">Restoring purchases</h2>

        <p>
          If you purchase premium features and then uninstall/reinstall the app
          - or if you try to use the premium features on a second device - you
          will need to click the <b>Restore purchases</b> button in the{' '}
          <b>Additional options</b> sidebar.
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

        <h2 id="saving-pictures-to-the-gallery">
          Saving pictures to the gallery
        </h2>

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
          <b>On iOS</b>, press the <b>Done</b> button to save your picture. The
          picture will be saved to the Photos app.
        </p>

        <p>
          <b>On Android</b>, press the checkmark icon to save your picture. The
          picture will be saved to a "Pictures" folder on your device. If you
          are using Google Photos, this folder can be accessed on the{' '}
          <b>Photos on device</b> screen.
        </p>
      </div>
    </div>
  );
}
