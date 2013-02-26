#!/bin/sh
mkdir -p log/sasl
erl -name loggerl@localhost -pa $PWD/ebin $PWD/deps/*/ebin -boot start_sasl -s loggerl -s erlbuild
