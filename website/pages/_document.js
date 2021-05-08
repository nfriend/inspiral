import Document, { Main, Head } from 'next/document';

// Copied from https://github.com/vercel/next.js/issues/5054#issuecomment-485169839

class CustomHead extends Head {
  render() {
    const res = super.render();

    function transform(node) {
      // remove all link preloads
      if (
        node &&
        node.type === 'link' &&
        node.props &&
        node.props.rel === 'preload'
      ) {
        return null;
      }
      if (node && node.props && node.props.children) {
        return {
          ...node,
          props: {
            ...node.props,
            children: Array.isArray(node.props.children)
              ? node.props.children.map(transform)
              : transform(node.props.children),
          },
        };
      }

      if (Array.isArray(node)) {
        return node.map(transform);
      }

      return node;
    }

    return transform(res);
  }
}

class StaticDocument extends Document {
  render() {
    return (
      <html>
        <CustomHead />
        <body>
          <Main />
        </body>
      </html>
    );
  }
}

export default process.env.NODE_ENV === 'production'
  ? StaticDocument
  : Document;
