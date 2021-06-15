# MEDIC DATABASE WORK

## About Project 💻

This application is responsible for searching for data in database mysql, generate one file from this data and sending this files from sftp.

## Getting Started 🏁

### Prerequisites

To clone and run this application, you'll need Git and Node.js installed on your computer.

### Installation

From your command line:

```bash
# This step only needs to be execute once on your computer and please make sure the registry URL is up to date
$ npm config set @mundiale-private:registry http://tup02apl027:8081/repository/mundiale-private/
```

```bash
# Clone this repository
$ git clone https://git.mundiale.com.br/metric/d1-mailing-remarketing-generate-file.git
```

# Go into the repository

$ cd d1-mailing-remarketing-generate-file

# Install dependencies

$ npm install

### Configuration

The application has a .env-example with the envinronment's variables.
Create and populate ".env" based on ".env-example".

### Usage

```bash
# Run
$ node cron.js
```

## Project Architecture 📁

```
.
├── logs
├── node_modules
├── src
│   ├── config
│   ├── controllers
│   └── services
├── temp_files
├── .env
├── .env-example
├── .eslintrc.json
├── .gitignore
├── cron.js
├── ecosystem.config.js
├── package-lock.json
├── package.json
└── README.md
```

## Technologies 🚀

- [Cron](https://www.npmjs.com/package/cron)
- [Dotenv](https://www.npmjs.com/package/dotenv)
- [Path](https://www.npmjs.com/package/path)
- [SSH2-SFTP-Client](https://www.npmjs.com/package/ssh2-sftp-client)
- [Winston](https://www.npmjs.com/package/winston)
- [Moment](https://www.npmjs.com/package/moment)
- [Mysql2](https://www.npmjs.com/package/mysql2)
- [xlsx](https://www.npmjs.com/package/xlsx)

## Mundiale Components ⚙️

- [Metrics](http://tup02git001/components/metrics)

## License 🔎

©️ Copyright 2021 Mundiale. All rights reserved.

This file is part of the D1 MAILING REMARKETING GENERATE FILE project.

The D1 MAILING REMARKETING GENERATE FILE project can not be copied and/or distributed without the express permission of Mundiale.
