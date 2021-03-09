const plugin = require('tailwindcss/plugin');

const basePath = process.env.NODE_ENV === 'production' ? '/inspiral' : '';

module.exports = {
  purge: ['./pages/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    fontFamily: {
      display: ['Playfair Display', 'serif'],
      body: ['Lato', 'ui-sans-serif', 'system-ui', 'sans-serif'],
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    plugin(function ({ addUtilities }) {
      const spiralBackgrounds = {
        '.spiral-background': {
          background: `url("${basePath}/images/landing-page-background.jpg") bottom left/30% no-repeat, url("${basePath}/images/landing-page-background-2.jpg") top right/20% no-repeat`,
        },
      };

      addUtilities(spiralBackgrounds, ['responsive']);
    }),
  ],
};
