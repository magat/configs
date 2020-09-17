#!/bin/sh

SETUP_DIR=~/Code/setup
docker run \
  -d -p 5432:5432 \
  -v $SETUP_DIR/postgres/home:/home/postgres \
  -v $SETUP_DIR/postgres/conf:/etc/postgresql \
  -v $SETUP_DIR/postgres/data:/var/lib/postgresql/data \
  -v $SETUP_DIR/postgres/logs:/var/log/postgresql \
  -v /tmp/dumps:/dumps \
  --name postgres \
  magat/postgres 
