from src.solve import Board, update_and_countup_otherwise_not as u
from src.numbers import simple_numbering
from src.points import simple_points
from src.loops import Ring, simple_loops
from src.solve import print_board

def advance_trios(var d: Board) raises -> Board:
    d = simple_numbering(d^, False)
    d = simple_points(d^, False)
    if d.b is not None and d.b.value():
        d.b = False
        d = advance_trios(d^)
    elif d.b is not None:
        d = simple_loops(d^)
    if d.b is not None and d.b.value():
        d.b = False
        d = advance_trios(d^)
    return d^

def hyp_scenarios(var b: Board, is_x: Bool, ti: Int, tj: Int) raises -> Board:
    var orig: Board = b.copy()
    if is_x:
        b.x[ti][tj] = 1
    else:
        b.y[ti][tj] = 1

    b = advance_trios(b^)
    if b.b is None:
        if is_x:
            orig.x[ti][tj] = 0
        else:
            orig.y[ti][tj] = 0
        orig = advance_trios(orig^)
        print_board(orig)
    return orig^

def hypothesis(var b: Board) raises -> Board:
    var orig: Board = b.copy()
    print("=")
    print("BEGIN HYPOTHESIS MODE")
    print("=")

    for i in range(b.h):
        for j in range(b.w):
            if b.f[i][j]:continue
            if b.x[i][j] not in [0,1]:
                b = hyp_scenarios(b^, True, i, j)
                if b.x[i][j] in [0,1]:
                    print("x", i, j, "||", b.x[i][j])
            if b.y[i][j] not in [0,1]:
                b = hyp_scenarios(b^, False, i, j)
                if b.y[i][j] in [0,1]:
                    print("y", i, j, "||", b.y[i][j])

    var judge: Bool = all([
        orig.p == b.p,
        orig.x == b.x,
        orig.y == b.y,
        orig.io == b.io
    ])
    b.b = (not judge)

    print("=")
    print("FINISH HYPOTHESIS MODE")
    print("=")

    return b^