from numbers import zero, one, two, three, simple_numbering
from points import simple_points

struct Board:
    var h: Int
    var w: Int
    var p: List[List[Int]]
    var x: List[List[Int]]
    var y: List[List[Int]]
    var n: List[List[Int]]
    var f: List[List[Bool]]
    var b: Bool

    def __init__(
        out self,
        var h: Int,
        var w: Int,
        var p: List[List[Int]],
        var x: List[List[Int]],
        var y: List[List[Int]],
        var n: List[List[Int]],
        var f: List[List[Bool]]
    ):
        self.h = h
        self.w = w
        self.p = p^
        self.x = x^
        self.y = y^
        self.n = n^
        self.f = f^
        self.b = False

def install_board() raises -> Board:
    var p: List[List[Int]] = []
    var x: List[List[Int]] = []
    var y: List[List[Int]] = []
    var n: List[List[Int]] = []
    var f: List[List[Bool]] = []

    var file = open("problems/problem.txt", "r")
    var text: String = file.read()
    var lines = text.split("\n")
    var size: List[Int] = [Int(i) for i in lines[0].split(",")]
    var h: Int = size[0]
    var w: Int = size[1]

    for line in lines[1:]:
        var row_n: List[Int] = [Int(j) if j else -1 for j in line.split(",")]
        n.append(row_n^)
        var row: List[Int] = [-1 for _k in range(w)]
        var row_excess: List[Int] = [-1 for _k in range(w+1)]
        x.append(row.copy())
        y.append(row_excess.copy())
        p.append(row_excess.copy())
        var flgs: List[Bool] = [False for _k in range(w)]
        f.append(flgs^)
    var bottom: List[Int] = [-1 for _k in range(w)]
    x.append(bottom^)

    file.close()
    return Board(h, w, p^, x^, y^, n^, f^)

def print_board(b: Board) raises -> None:
    var disp_x: Dict[Int, String] = {-1:" ", 0:"x", 1:"-", -2: "?"}
    var disp_y: Dict[Int, String] = {-1:" ", 0:"x", 1:"|", -2: "?"}
    var disp_n: Dict[Int, String] = {-1:" ", 0:"0", 1:"1", 2:"2", 3:"3"}

    print()
    for row in range(b.h):
        var upper: List[String] = []
        var lower: List[String] = []
        for i in b.x[row]:
            upper.append("· " + disp_x[i])
        upper.append("·")
        for i in zip(b.y[row], b.n[row]):
            lower.append(disp_y[i[0]] + " " + disp_n[i[1]])
        lower.append(disp_y[b.y[row][b.w]])
        print(" ".join(upper))
        print(" ".join(lower))
    var bottom: List[String] = ["· " + disp_x[btm] for btm in b.x[b.h]]
    bottom.append("·")
    print(" ".join(bottom))
    print()

def update_and_countup_otherwise_not(mut v: Int, mut c: Bool, desire: Int):
    var diff: Bool = (v != desire)
    if diff:
        v = desire
    c = c or diff

def numbers_and_points(var board_map: Board) raises -> Board:
    board_map = simple_numbering(board_map^)
    print_board(board_map)
    board_map = simple_points(board_map^)
    print_board(board_map)
    if board_map.b:
        print("Retake numbers&points set.")
        board_map.b = False
        board_map = numbers_and_points(board_map^)
    return board_map^

def main() raises:
    # install question
    var board_map: Board = install_board()
    print_board(board_map)
    board_map = numbers_and_points(board_map^)
