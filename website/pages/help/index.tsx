import HelpCustomHead from './help-custom-head';

export default function Home() {
  return (
    <div className="help w-screen h-screen p-10 flex justify-center">
      <div className="max-w-xl">
        <HelpCustomHead />

        <h1>Table of contents</h1>

        <ul className="list-disc list-inside">
          <li>
            <a href="#selecting-a-new-pen-hole">Selecting a new pen hole</a>
          </li>
        </ul>

        <h2 id="selecting-a-new-pen-hole">Selecting a new pen hole</h2>

        <p>
          You can select a different hole by opening the "Tools" tab and
          pressing the first button in the top row. This will zoom in on the
          rotating gear and allow you to select any of the available holes.
          Press the button again to zoom back out.
        </p>

        <img
          src="help/images/select-hole-button.png"
          alt="A screenshot of the 'select hole' button"
        />
      </div>
    </div>
  );
}
