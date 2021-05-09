import Head from 'next/head';

export default function HelpCustomHead() {
  return (
    <Head>
      <title>Inspiral Help</title>

      <meta property="og:title" key="title" content="Inspiral Help" />
      <meta
        property="og:description"
        key="description"
        content="Help and instructions for the Inspiral app."
      />
      <meta property="og:type" content="website" />
      <meta property="og:url" content="https://inspiral.nathanfriend.io/help" />
      <meta
        property="og:image"
        content="https://inspiral.nathanfriend.io/images/og-image.jpg"
      />
    </Head>
  );
}
