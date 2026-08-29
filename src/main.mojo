from std.time import sleep

struct Board:
    var h: Int
    var w: Int
    var p: List[List[Int]]
    var x: List[List[Int]]
    var y: List[List[Int]]
    var n: List[List[Int]]
    var f: List[List[Bool]]

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
    # sleep(0.5)
    var disp_x: Dict[Int, String] = {-1:" ", 0:"x", 1:"-"}
    var disp_y: Dict[Int, String] = {-1:" ", 0:"x", 1:"|"}
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

def check_cell(mut b: Board, i: Int, j: Int, var ctrl: Int) -> Bool:
    var lines: Int = 0
    var crosses: Int = 0
    var c: Bool = False
    for v in [b.x[i][j], b.x[i+1][j], b.y[i][j], b.y[i][j+1]]:
        if v == 1:
            lines += 1
        if v == 0:
            crosses += 1
    if lines == ctrl:
        if b.x[i][j]   == -1:update_and_countup_otherwise_not(b.x[i][j],   c, 0)
        if b.x[i+1][j] == -1:update_and_countup_otherwise_not(b.x[i+1][j], c, 0)
        if b.y[i][j]   == -1:update_and_countup_otherwise_not(b.y[i][j],   c, 0)
        if b.y[i][j+1] == -1:update_and_countup_otherwise_not(b.y[i][j+1], c, 0)
    if crosses == 4 - ctrl:
        if b.x[i][j]   == -1:update_and_countup_otherwise_not(b.x[i][j],   c, 1)
        if b.x[i+1][j] == -1:update_and_countup_otherwise_not(b.x[i+1][j], c, 1)
        if b.y[i][j]   == -1:update_and_countup_otherwise_not(b.y[i][j],   c, 1)
        if b.y[i][j+1] == -1:update_and_countup_otherwise_not(b.y[i][j+1], c, 1)
    return c

def skip_non_number(mut b: Board, i: Int, j: Int, x: Int, y: Int) -> Bool:
    return False

def zero(mut b: Board, i: Int, j: Int, x: Int, y: Int) -> Bool:
    if b.f[i][j]:
        return False
    var c: Bool = False
    update_and_countup_otherwise_not(b.x[i][j],   c, 0)
    update_and_countup_otherwise_not(b.x[i+1][j], c, 0)
    update_and_countup_otherwise_not(b.y[i][j],   c, 0)
    update_and_countup_otherwise_not(b.y[i][j+1], c, 0)
    b.f[i][j] = True
    return c

def one(mut b: Board, i: Int, j: Int, x: Int, y: Int) -> Bool:
    if b.f[i][j]:
        return False
    # TODO: impl.
    var c: Bool = False
    var tf: Bool = check_cell(b, i, j, 1)
    c = (c or tf)

    # b.f[i][j] = True
    return c

def two(mut b: Board, i: Int, j: Int, x: Int, y: Int) -> Bool:
    if b.f[i][j]:
        return False
    # TODO: impl.
    var c: Bool = False
    var tf: Bool = check_cell(b, i, j, 2)
    c = (c or tf)
    # b.f[i][j] = True
    return c

def three(mut b: Board, i: Int, j: Int, x: Int, y: Int) -> Bool:
    if b.f[i][j]:
        return False
    # TODO: impl.
    var c: Bool = False
    var tf: Bool = check_cell(b, i, j, 3)
    c = (c or tf)
    # 3-3pair
    if i != 0 and b.n[i-1][j] == 3:
        update_and_countup_otherwise_not(b.x[i-1][j], c, 1)
        update_and_countup_otherwise_not(b.x[i][j],   c, 1)
        update_and_countup_otherwise_not(b.x[i+1][j], c, 1)
        if j != 0:
            update_and_countup_otherwise_not(b.x[i][j-1], c, 0)
        if j != b.w - 1:
            update_and_countup_otherwise_not(b.x[i][j+1], c, 0)
    if i != b.h - 1 and b.n[i+1][j] == 3:
        update_and_countup_otherwise_not(b.x[i][j],   c, 1)
        update_and_countup_otherwise_not(b.x[i+1][j], c, 1)
        update_and_countup_otherwise_not(b.x[i+2][j], c, 1)
        if j != 0:
            update_and_countup_otherwise_not(b.x[i+1][j-1], c, 0)
        if j != b.w - 1:
            update_and_countup_otherwise_not(b.x[i+1][j+1], c, 0)
    if j != 0 and b.n[i][j-1] == 3:
        update_and_countup_otherwise_not(b.y[i][j-1], c, 1)
        update_and_countup_otherwise_not(b.y[i][j],   c, 1)
        update_and_countup_otherwise_not(b.y[i][j+1], c, 1)
        if i != 0:
            update_and_countup_otherwise_not(b.y[i-1][j], c, 0)
        if i != b.w - 1:
            update_and_countup_otherwise_not(b.y[i+1][j], c, 0)
    if j != b.w - 1 and b.n[i][j+1] == 3:
        update_and_countup_otherwise_not(b.y[i][j],   c, 1)
        update_and_countup_otherwise_not(b.y[i][j+1], c, 1)
        update_and_countup_otherwise_not(b.y[i][j+2], c, 1)
        if i != 0:
            update_and_countup_otherwise_not(b.y[i-1][j+1], c, 0)
        if i != b.h - 1:
            update_and_countup_otherwise_not(b.y[i+1][j+1], c, 0)

    # corner
    if x == 0 and y == 0:
        update_and_countup_otherwise_not(b.x[0][0], c, 1)
        update_and_countup_otherwise_not(b.y[0][0], c, 1)
    if x == 0 and y == 1:
        update_and_countup_otherwise_not(b.x[0][b.w-1], c, 1)
        update_and_countup_otherwise_not(b.y[0][b.w], c, 1)
    if x == 1 and y == 0:
        update_and_countup_otherwise_not(b.x[b.h][0], c, 1)
        update_and_countup_otherwise_not(b.y[b.h-1][0], c, 1)
    if x == 1 and y == 1:
        update_and_countup_otherwise_not(b.x[b.h][b.w-1], c, 1)
        update_and_countup_otherwise_not(b.y[b.h-1][b.w], c, 1)
    #

    # b.f[i][j] = True
    return c

def simple_numbering(var b: Board) raises -> Board:
    var treat: Dict[Int, def(mut Board, Int, Int, Int, Int) thin -> Bool] = {
        -1:skip_non_number,
        0:zero, 1:one, 2:two, 3:three
    }
    var cnt: Bool = False
    for i in range(b.h):
        var yedge: Int
        if i % (b.h-1):
            yedge = i // (b.h-1)
        else:
            yedge = -1
        for j in range(b.w):
            var xedge: Int
            if i % (b.w-1):
                xedge = i // (b.w-1)
            else:
                xedge = -1
            var temp: Bool = treat[b.n[i][j]](b, i, j, xedge, yedge)
            cnt = cnt or temp
    if cnt:
        print("Iteration begin.")
        b = simple_numbering(b^)
    return b^

def main() raises:
    # install question
    var board_map: Board = install_board()
    print_board(board_map)
    board_map = simple_numbering(board_map^)
    print_board(board_map)

