import Head from 'next/head';

export default function Home() {
  return (
    <div>
      <Head>
        <title>Inspiral</title>

        <link
          rel="apple-touch-icon"
          sizes="180x180"
          href="/apple-touch-icon.png"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="32x32"
          href="/favicon-32x32.png"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="16x16"
          href="/favicon-16x16.png"
        />
        <link rel="manifest" href="/site.webmanifest" />
        <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5" />
        <meta name="msapplication-TileColor" content="#da532c" />
        <meta name="theme-color" content="#ffffff" />
      </Head>

      <main className="sm:h-screen flex flex-col sm:bg-spirals bg-left-bottom bg-no-repeat bg-40%">
        <div className="flex-1 flex flex-col sm:flex-row items-center justify-center min-h-0">
          <div className="sm:flex-1 flex justify-end text-center sm:pb-40">
            <div className="px-10">
              <header>
                <h1 className="text-7xl font-display tracking-tight py-10">
                  Get Inspiral-ed
                </h1>
              </header>
              <p>Relive your childhood in pixel-perfect bliss.</p>
              <div className="flex justify-center">
                <img
                  src="images/google-play-badge.svg"
                  className="flex-1 app-store-button mr-5"
                />
                <img
                  src="images/app-store-badge.svg"
                  className="flex-1 app-store-button"
                />
              </div>
              <div className="flex justify-center">
                <img src="images/coming-soon.png" className="w-40" />
              </div>
            </div>
          </div>
          <div className="flex-1">
            <img
              className="sm:flex-1 sm:py-10 max-h-90-screen"
              alt="A screenshot of the Inspiral app"
              src="images/screenshot.jpg"
            />
          </div>
        </div>
        <footer className="flex-initial flex justify-center py-2 text-sm">
          <a href="https://gitlab.com/nfriend/inspiral" className="px-3">
            Source
          </a>
          <p className="px-3">
            Copyright <a href="https://nathanfriend.io">Nathan Friend</a> © 2020
          </p>
        </footer>
      </main>
    </div>
  );
}
