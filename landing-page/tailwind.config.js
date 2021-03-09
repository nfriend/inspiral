module.exports = {
  purge: ['./pages/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    fontFamily: {
      display: ['Playfair Display', 'serif'],
      body: ['Lato', 'ui-sans-serif', 'system-ui', 'sans-serif'],
    },
    extend: {
      backgroundSize: {
        '40%': '40%',
      },
      backgroundImage: {
        spirals: `url("${
          process.env.NODE_ENV === 'production' ? '/inspiral' : ''
        }/images/landing-page-background.jpg")`,
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
