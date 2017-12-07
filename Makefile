.PHONY: test

test: sbtest.sh
	./sbtest.sh --src aoc --tests bash_tests

sbtest.sh:
	wget https://github.com/internap/sbtest/releases/download/0.1.3/sbtest.sh
	chmod +x sbtest.sh
