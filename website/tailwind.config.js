const plugin = require('tailwindcss/plugin');

module.exports = {
  purge: ['./pages/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        display: ['Playfair Display', 'serif'],
        body: ['Lato', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      backgroundColor: {
        beige: '#f7efda',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    plugin(function ({ addUtilities }) {
      const spiralBackgrounds = {
        '.spiral-background': {
          background: `url("/images/website-background.jpg") bottom left/30% no-repeat, url("/images/website-background-2.jpg") top right/20% no-repeat`,
        },
      };

      addUtilities(spiralBackgrounds, ['responsive']);
    }),
  ],
};
