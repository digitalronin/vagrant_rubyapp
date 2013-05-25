#!/bin/bash
/usr/bin/wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p429.tar.gz
/bin/tar -xvzf ruby-1.9.3-p429.tar.gz
cd ruby-1.9.3-p429/
./configure
/usr/bin/make
/usr/bin/make install
