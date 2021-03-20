const path = require('path');
const { google } = require('googleapis');
const yargs = require('yargs/yargs');
const { hideBin } = require('yargs/helpers');
const argv = yargs(hideBin(process.argv)).argv;

const androidpublisher = google.androidpublisher('v3');

(async () => {
  const auth = new google.auth.GoogleAuth({
    scopes: ['https://www.googleapis.com/auth/androidpublisher'],
    projectId: require(path.resolve(__dirname, 'project.json')),
    keyFile: path.resolve(__dirname, 'key.json'),
  });

  const authClient = await auth.getClient();
  google.options({ auth: authClient });

  const res = await androidpublisher.orders.refund({
    orderId: argv.orderId,
    packageName: 'io.nathanfriend.inspiral',
    revoke: true,
  });

  console.log(res.data);
})().catch((err) => {
  console.error('Something went wrong!');
  console.error(err);
});
