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
  plugins: [],
};
