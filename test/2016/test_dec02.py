import unittest

from aoc.seize.dec02 import Grid
from hamcrest import assert_that, is_


class GridTest(unittest.TestCase):
    def setUp(self):
        self.grid = Grid()

    def test_initial_position(self):
        assert_that(self.grid.pos, is_(5))

    def test_move_up(self):
        self.grid.up()
        assert_that(self.grid.pos, is_(2))

    def test_move_down(self):
        self.grid.down()
        assert_that(self.grid.pos, is_(8))

    def test_move_left(self):
        self.grid.left()
        assert_that(self.grid.pos, is_(4))
