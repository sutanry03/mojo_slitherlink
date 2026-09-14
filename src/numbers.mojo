from src.solve import Board, update_and_countup_otherwise_not as u
from src.signs.common import check_io, diagonal_neighbors
from src.signs.one import first
from src.signs.two import second
from src.signs.three import third
from src.solve import print_board

def simple_numbering(var b: Board, var printout: Bool=True) raises -> Board:
    var treat: Dict[Int, def(mut Board, Int, Int, Int, Int) thin raises -> Bool] = {
        -1:non_number,
        0:zero, 1:first, 2:second, 3:third
    }
    var cnt: Bool = False
    for i in range(b.h):
        var yedge: Int
        if i % (b.h-1):
            yedge = -1
        else:
            yedge = i // (b.h-1)
        for j in range(b.w):
            var xedge: Int
            if j % (b.w-1):
                xedge = -1
            else:
                xedge = j // (b.w-1)
            var temp: Bool = treat[b.n[i][j]](b, i, j, xedge, yedge)
            cnt = cnt or temp
            #io check
            if b.io[i][j] is None:
                check_io(b, cnt, i, j)

    if cnt:
        b.b = True
        if printout:
            print("Iteration (numbers) begin.")
        b = simple_numbering(b^, printout)
    return b^

def non_number(mut b: Board, i: Int, j: Int, x: Int, y: Int) raises -> Bool:
    var c: Bool = False
    var diag: Tuple[Int, Int, Int, Int] = diagonal_neighbors(b, i, j)

    if i == 10 and j == 13:
        print()
        print("yoh", diag, b.x[i][j], b.x[i+1][j], b.y[i][j], b.y[i][j+1])

    if diag[0] == 0 and b.x[i+1][j] == 1 and b.y[i][j] == 1:
        u(b.x[i][j], c, 0)
        u(b.y[i][j+1], c, 0)
    if diag[1] == 0 and b.x[i+1][j] == 1 and b.y[i][j+1] == 1:
        u(b.x[i][j], c, 0)
        u(b.y[i][j], c, 0)
    if diag[2] == 0 and b.x[i][j] == 1 and b.y[i][j+1] == 1:
        u(b.x[i+1][j], c, 0)
        u(b.y[i][j], c, 0)
    if diag[3] == 0 and b.x[i][j] == 1 and b.y[i][j] == 1:
        u(b.x[i+1][j], c, 0)
        u(b.y[i][j+1], c, 0)

    if diag[0] == 0 and diag[1] == 0:
        if diag[2] in [-3, 1]:
            if i != b.h-1 and j != b.w-1:
                if b.n[i+1][j+1] == 1:
                    u(b.x[i+2][j+1], c, 0)
                    u(b.y[i+1][j+2], c, 0)
                if b.n[i+1][j+1] == 3:
                    u(b.x[i+2][j+1], c, 1)
                    u(b.y[i+1][j+2], c, 1)
        if diag[3] in [-3, 1]:
            if i != b.h-1 and j != 0:
                if b.n[i+1][j-1] == 1:
                    u(b.x[i+2][j-1], c, 0)
                    u(b.y[i+1][j-1], c, 0)
                if b.n[i+1][j-1] == 3:
                    u(b.x[i+2][j-1], c, 1)
                    u(b.y[i+1][j-1], c, 1)
    if diag[1] == 0 and diag[2] == 0:
        if diag[0] in [-3, 1]:
            if i != b.h-1 and j != b.w-1:
                if b.n[i+1][j+1] == 1:
                    u(b.x[i+2][j+1], c, 0)
                    u(b.y[i+1][j+2], c, 0)
                if b.n[i+1][j+1] == 3:
                    u(b.x[i+2][j+1], c, 1)
                    u(b.y[i+1][j+2], c, 1)
        if diag[3] in [-3, 1]:
            if i != 0 and j != b.w-1:
                if b.n[i-1][j+1] == 1:
                    u(b.x[i-1][j+1], c, 0)
                    u(b.y[i-1][j+2], c, 0)
                if b.n[i-1][j+1] == 3:
                    u(b.x[i-1][j+1], c, 1)
                    u(b.y[i-1][j+2], c, 1)
    if diag[2] == 0 and diag[3] == 0:
        if diag[0] in [-3, 1]:
            if i != 0 and j != 0:
                if b.n[i-1][j-1] == 1:
                    u(b.x[i-1][j-1], c, 0)
                    u(b.y[i-1][j-1], c, 0)
                if b.n[i-1][j-1] == 3:
                    u(b.x[i-1][j-1], c, 1)
                    u(b.y[i-1][j-1], c, 1)
        if diag[1] in [-3, 1]:
            if i != 0 and j != b.w-1:
                if b.n[i-1][j+1] == 1:
                    u(b.x[i-1][j+1], c, 0)
                    u(b.y[i-1][j+2], c, 0)
                if b.n[i-1][j+1] == 3:
                    u(b.x[i-1][j+1], c, 1)
                    u(b.y[i-1][j+2], c, 1)
    if diag[3] == 0 and diag[0] == 0:
        if diag[1] in [-3, 1]:
            if i != b.h-1 and j != 0:
                if b.n[i+1][j-1] == 1:
                    u(b.x[i+2][j-1], c, 0)
                    u(b.y[i+1][j-1], c, 0)
                if b.n[i+1][j-1] == 3:
                    u(b.x[i+2][j-1], c, 1)
                    u(b.y[i+1][j-1], c, 1)
        if diag[2] in [-3, 1]:
            if i != 0 and j != 0:
                if b.n[i-1][j-1] == 1:
                    u(b.x[i-1][j-1], c, 0)
                    u(b.y[i-1][j-1], c, 0)
                if b.n[i-1][j-1] == 3:
                    u(b.x[i-1][j-1], c, 1)
                    u(b.y[i-1][j-1], c, 1)

    if i == 10 and j == 13:
        print("yoh", diag, b.x[i][j], b.x[i+1][j], b.y[i][j], b.y[i][j+1])
        print()

    return c

def zero(mut b: Board, i: Int, j: Int, x: Int, y: Int) raises -> Bool:
    if b.f[i][j]:
        return False
    var c: Bool = False
    u(b.x[i][j],   c, 0)
    u(b.x[i+1][j], c, 0)
    u(b.y[i][j],   c, 0)
    u(b.y[i][j+1], c, 0)
    b.f[i][j] = True
    return c

