const path = require('path');

module.exports = {
  basePath: '/inspiral',
  sassOptions: {
    includePaths: [path.join(__dirname, 'styles')],
  },
};
