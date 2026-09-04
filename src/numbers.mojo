from src.solve import Board, update_and_countup_otherwise_not as u
from src.signs.one import first
from src.signs.two import second
from src.signs.three import third

def simple_numbering(var b: Board) raises -> Board:
    var treat: Dict[Int, def(mut Board, Int, Int, Int, Int) thin raises -> Bool] = {
        -1:skip_non_number,
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
    if cnt:
        b.b = True
        print("Iteration (numbers) begin.")
        b = simple_numbering(b^)
    return b^

def skip_non_number(mut b: Board, i: Int, j: Int, x: Int, y: Int) raises -> Bool:
    return False

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

