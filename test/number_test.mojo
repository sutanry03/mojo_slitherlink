from src.solve import Board
from src.signs.common import check_cell
from src.signs.one import first
from src.signs.two import second
from src.signs.three import third
from src.numbers import non_number, zero
from src.solve import print_board
from std.testing import assert_equal, TestSuite
from std.traits import AnyType

def test_dummy() raises:
    assert_equal(1, 1)

def make_lists_int(
    var v: Int, width: Int, height: Int
) -> List[List[Int]]:
    return [
        [v for _i in range(width)]
        for _j in range(height)
    ]

def make_lists_bool(
    var v: Bool, width: Int, height: Int
) -> List[List[Bool]]:
    return [
        [v for _i in range(width)]
        for _j in range(height)
    ]

def make_board(
    var no: Int,
    var p:  List[List[Int]] = make_lists_int(-1, 4, 4),
    var x:  List[List[Int]] = make_lists_int(-1, 3, 4),
    var y:  List[List[Int]] = make_lists_int(-1, 4, 3),
    var f:  List[List[Bool]] = make_lists_bool(False, 3, 3),
    var l:  Dict[String, List[List[Int]]] = {
        "x":make_lists_int(-1, 3, 4),
        "y":make_lists_int(-1, 4, 3)
    },
    var io: List[List[Optional[Bool]]] = [
        [None,None,None],
        [None,None,None],
        [None,None,None]
    ]
) -> Board:
    var n: List[List[Int]] = make_lists_int(-1, 3, 3)
    n[1][1] = no
    var b: Board = Board(3,3,p^,x^,y^,n^,f^,l^,io^)
    return b^

def test_zero() raises:
    var b: Board = make_board(0)
    _ = zero(b,1,1,-1,-1)

    var rx: List[List[Int]] = [
        [-1,-1,-1],
        [-1,0,-1],
        [-1,0,-1],
        [-1,-1,-1]
    ]
    var ry: List[List[Int]] = [
        [-1,-1,-1,-1],
        [-1,0,0,-1],
        [-1,-1,-1,-1]
    ]
    assert_equal(b.x, rx)
    assert_equal(b.y, ry)

# def test_one() raises:
#     var b: Board = make_board(1)
    # print_board(b)
    # _ = first(b,1,1,-1,-1)
    # var rx: List[List[Int]] = [
    #     [-1,-1,-1],
    #     [-1,1,-1],
    #     [-1,0,-1],
    #     [-1,-1,-1]
    # ]
    # var ry: List[List[Int]] = [
    #     [-1,-1,-1,-1],
    #     [-1,0,0,-1],
    #     [-1,-1,-1,-1]
    # ]
    # assert_equal(b.x, rx)
    # assert_equal(b.y, ry)

# __init__.mojoをいれるとLSPエラー
def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()
