#!/bin/bash
ROOT_URL=http://www1.pennasol.su:9999/ \
PORT=9999 \
MONGO_URL=mongodb://localhost/price_stock \
MAIL_URL=smtp://localhost:25 \
node bundle/main.js
