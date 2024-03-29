import Head from 'next/head';

export default function CustomHead() {
  return (
    <Head>
      <title>Inspiral</title>

      <meta property="og:title" key="title" content="Inspiral" />
      <meta
        property="og:description"
        key="description"
        content="Relive your childhood in pixel-perfect bliss. Available for iOS and Android."
      />
      <meta property="og:type" content="website" />
      <meta property="og:url" content="https://inspiral.nathanfriend.io/" />
      <meta
        property="og:image"
        content="https://inspiral.nathanfriend.io/images/og-image.jpg"
      />

      <script
        async
        src="https://www.googletagmanager.com/gtag/js?id=G-4V3M4MTGM3"
      ></script>
      <script src="/js/ga.js"></script>
    </Head>
  );
}
