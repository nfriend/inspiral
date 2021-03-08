const path = require('path');

module.exports = {
  basePath: process.env.NODE_ENV === 'production' ? '/inspiral' : '',
  sassOptions: {
    includePaths: [path.join(__dirname, 'styles')],
  },
};
