import unittest

from hamcrest import assert_that, is_

from aoc.dix_sept.day6 import redistribute, redist_until_already_seen, redist_until_already_seen_twice

blocks = [int(b) for b in "4	1	15	12	0	9	9	5	5	8	7	3	14	5	12	3".split()]

class Day6Test(unittest.TestCase):
    def test_example(self):
            a = [0, 2, 7, 0]
            out = redistribute(a)
            assert_that(out, is_([2, 4, 1, 2]))

            out = redistribute(out)
            assert_that(out, is_([3, 1, 2, 3]))


    def test_until_seen(self):
        assert_that(redist_until_already_seen([0, 2, 7, 0]),
                    is_(5))

    def test_until_seen_again(self):
        assert_that(redist_until_already_seen_twice([0, 2, 7, 0]),
                    is_(4))

