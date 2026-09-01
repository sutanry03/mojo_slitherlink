from numbers import zero, one, two, three, simple_numbering
from points import simple_points
from loops import Ring, simple_loops

struct Board:
    var h: Int                           # height of board
    var w: Int                           # width of board
    var p: List[List[Int]]               # points around numbers
    var x: List[List[Int]]               # horizontall ines
    var y: List[List[Int]]               # vertical lines
    var n: List[List[Int]]               # numbers given by problem
    var f: List[List[Bool]]              # flag for number
    var b: Bool                          # bool for record update or not
    var l: Dict[String, List[List[Int]]] # loops numbers belongs to.
    var r: List[Ring]                    # rings catalog.

    def __init__(
        out self,
        var h: Int,
        var w: Int,
        var p: List[List[Int]],
        var x: List[List[Int]],
        var y: List[List[Int]],
        var n: List[List[Int]],
        var f: List[List[Bool]],
        var l: Dict[String, List[List[Int]]]
    ):
        self.h = h
        self.w = w
        self.p = p^
        self.x = x^
        self.y = y^
        self.n = n^
        self.f = f^
        self.b = False
        self.l = l^
        self.r = []

def install_board() raises -> Board:
    var p: List[List[Int]] = []
    var x: List[List[Int]] = []
    var y: List[List[Int]] = []
    var n: List[List[Int]] = []
    var f: List[List[Bool]] = []
    var l: Dict[String, List[List[Int]]] = {"x":[], "y":[]}

    var file = open("problems/problem.txt", "r")
    var text: String = file.read()
    var lines = text.split("\n")
    var size: List[Int] = [Int(i) for i in lines[0].split(",")]
    var h: Int = size[0]
    var w: Int = size[1]

    var row: List[Int] = [-1 for _k in range(w)]
    var row_excess: List[Int] = [-1 for _k in range(w+1)]
    for line in lines[1:]:
        var row_n: List[Int] = [Int(j) if j else -1 for j in line.split(",")]
        n.append(row_n^)
        var flgs: List[Bool] = [False for _k in range(w)]
        f.append(flgs^)

        x.append(row.copy())
        y.append(row_excess.copy())
        p.append(row_excess.copy())
        l["x"].append(row.copy())
        l["y"].append(row_excess.copy())

    x.append(row.copy())
    l["x"].append(row.copy())
    p.append(row_excess.copy())

    file.close()
    return Board(h, w, p^, x^, y^, n^, f^, l^)

def print_board(b: Board) raises -> None:
    var disp_x: Dict[Int, String] = {-1:" ", 0:"x", 1:"-", -2: "?"}
    var disp_y: Dict[Int, String] = {-1:" ", 0:"x", 1:"|", -2: "?"}
    var disp_n: Dict[Int, String] = {-1:" ", 0:"0", 1:"1", 2:"2", 3:"3"}
    var disp_p: Dict[Int, String] = {
        -1:"·", 0: " ", 5: "─", 6: "│",
        1:"└", 2:"┘", 3:"┐", 4:"┌"
    }

    print()
    for row in range(b.h):
        var upper: List[String] = []
        var lower: List[String] = []
        for i, j in zip(b.p[row], b.x[row]):
            upper.append(disp_p[i] + " " + disp_x[j])
        upper.append(disp_p[b.p[row][b.w]])
        for i in zip(b.y[row], b.n[row]):
            lower.append(disp_y[i[0]] + " " + disp_n[i[1]])
        lower.append(disp_y[b.y[row][b.w]])
        print(" ".join(upper))
        print(" ".join(lower))
    var bottom: List[String] = [
        disp_p[btm_p] + " " + disp_x[btm_x]
        for btm_p, btm_x in zip(b.p[b.h], b.x[b.h])
    ]
    bottom.append(disp_p[b.p[b.h][b.w]])
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
    else:
        print("Through numbers&points set. Begin loop_check.")
        board_map = simple_loops(board_map^)
        print_board(board_map)
    if board_map.b:
        print("Change detected. Retake trio set.")
        board_map.b = False
        board_map = numbers_and_points(board_map^)
    return board_map^

def main() raises:
    # install question
    var board_map: Board = install_board()
    print_board(board_map)
    board_map = numbers_and_points(board_map^)
    print("Through simple-trio set.")
    print(board_map.h, board_map.w, len(board_map.r))
