struct Board:
    var h: Int
    var w: Int
    var p: List[List[Int]]
    var x: List[List[Int]]
    var y: List[List[Int]]
    var n: List[List[Int]]

    def __init__(
        out self,
        var h: Int,
        var w: Int,
        var p: List[List[Int]],
        var x: List[List[Int]],
        var y: List[List[Int]],
        var n: List[List[Int]]
    ):
        self.h = h
        self.w = w
        self.p = p^
        self.x = x^
        self.y = y^
        self.n = n^

def install_board() raises -> Board:
    var p: List[List[Int]] = []
    var x: List[List[Int]] = []
    var y: List[List[Int]] = []
    var n: List[List[Int]] = []

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
    var bottom: List[Int] = [-1 for _k in range(w)]
    x.append(bottom^)

    file.close()
    return Board(h, w, p^, x^, y^, n^)

def print_board(b: Board) raises -> None:
    var disp_x: Dict[Int, String] = {-1:" ", 0:"x", 1:"-"}
    var disp_y: Dict[Int, String] = {-1:" ", 0:"x", 1:"|"}
    var disp_n: Dict[Int, String] = {-1:" ", 0:"0", 1:"1", 2:"2", 3:"3"}

    print()
    for row in range(b.h):
        var upper: List[String] = []
        var lower: List[String] = []
        for i in zip(b.p[row], b.x[row]):
            upper.append("· " + disp_x[i[1]])
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

def main() raises:
    # install question
    var board_map: Board = install_board()
    print_board(board_map)


