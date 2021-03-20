# Development utility

This small node app is used during development to delete in app purchases so
that they can be tested more than once.

## Setup

1. Run `yarn` in this directory
1. Create a `project.json` file in this directory that contains the project ID
   of the Google Play Console API project, wrapped in double quotes:

   ```json
   "<google play console API project ID here>"
   ```

1. Copy the service account's `key.json` file to this directory
   - This file can be found in KeePass

## Usage

```sh
yarn revoke-purchase --order-id="GPA.5555-5555-5555-55555"
```
