#!/bin/sh
mkdir -p log/sasl
erl -sname loggerl -pa $PWD/ebin $PWD/deps/*/ebin -boot start_sasl -s loggerl -s erlbuild -s toolbar
