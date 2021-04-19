import Head from 'next/head';

export default function Home() {
  const socialIcons = [
    {
      icon: 'instagram',
      alt: 'Instagram logo',
      link: 'https://www.instagram.com/inspiral.nathanfriend.io/',
    },
    {
      icon: 'facebook',
      alt: 'Facebook logo',
      link: 'https://www.facebook.com/inspiral.nathanfriend.io',
    },
    {
      icon: 'twitter',
      alt: 'Twitter logo',
      link: 'https://twitter.com/inspiral_app',
    },
    {
      icon: 'tumblr',
      alt: 'Tumblr logo',
      link: 'https://inspiral-app.tumblr.com/',
    },
    {
      icon: 'gitlab',
      alt: 'GitLab logo',
      link: 'https://gitlab.com/nfriend/inspiral',
    },
    {
      icon: 'email',
      alt: 'Email logo',
      link: 'mailto:inspiral@nathanfriend.io',
    },
  ].map((iconInfo) => (
    <a key={iconInfo.icon} href={iconInfo.link} target="_blank" rel="noopener">
      <img
        className="w-10 mr-3"
        src={`images/social-icons/${iconInfo.icon}.svg`}
      />
    </a>
  ));

  return (
    <div>
      <Head>
        <title>Inspiral</title>
      </Head>

      <main className="sm:h-screen flex flex-col sm:spiral-background">
        <div className="flex-1 flex flex-col sm:flex-row items-center justify-center min-h-0">
          <div className="sm:flex-1 flex justify-end text-center sm:pb-40">
            <div className="px-10 sm:pt-40">
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
              <div className="flex justify-center pb-10">
                <img src="images/coming-soon.png" className="w-40" />
              </div>
              <div className="flex justify-center">{socialIcons}</div>
            </div>
          </div>
          <div className="flex-1">
            <img
              className="sm:flex-1 sm:py-10 max-h-90-screen"
              alt="A screenshot of the Inspiral app"
              src="images/screenshot.png"
            />
          </div>
        </div>
        <footer className="flex-initial flex justify-center py-2 text-sm">
          <p className="px-3">
            Copyright <a href="https://nathanfriend.io">Nathan Friend</a> © 2020
          </p>
        </footer>
      </main>
    </div>
  );
}
