#!/usr/bin/env node

import * as crypto from 'crypto';

const digest = crypto.hash('sha1','src/crypto.cpp');

console.log(digest);
