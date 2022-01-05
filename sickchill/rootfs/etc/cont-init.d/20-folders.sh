#!/bin/bash

if [ ! -d /share/storage/movies ]; then
  echo "Creating /share/storage/movies"
  mkdir -p /share/storage/movies
  chown -R abc:abc /share/storage/movies
fi

if [ ! -d /share/storage/tv ]; then
  echo "Creating /share/storage/tv"
  mkdir -p /share/storage/tv
  chown -R abc:abc /share/storage/tv
fi

if [ ! -d /share/downloads ]; then
  echo "Creating /share/downloads"
  mkdir -p /share/downloads
  chown -R abc:abc /share/downloads
fi

if [ -d /config/sickchill ] && [ ! -d /config/addons_config/sickchill ]; then
  echo "Moving to new location /config/addons_config/sickchill"
  mkdir -p /config/addons_config/sickchill
  chown -R abc:abc /config/addons_config/sickchill
  mv /config/sickchill/* /config/addons_config/sickchill/
  rm -r /config/sickchill
fi

if [ ! -d /config/addons_config/sickchill ]; then
  echo "Creating /config/addons_config/sickchill"
  mkdir -p /config/addons_config/sickchill
  chown -R abc:abc /config/addons_config/sickchill
fi
