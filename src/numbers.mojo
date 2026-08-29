from main import Board, update_and_countup_otherwise_not

def simple_numbering(var b: Board) raises -> Board:
    var treat: Dict[Int, def(mut Board, Int, Int, Int, Int) thin -> Bool] = {
        -1:skip_non_number,
        0:zero, 1:one, 2:two, 3:three
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
        if b.x[i][j]   <= -1:update_and_countup_otherwise_not(b.x[i][j],   c, 0)
        if b.x[i+1][j] <= -1:update_and_countup_otherwise_not(b.x[i+1][j], c, 0)
        if b.y[i][j]   <= -1:update_and_countup_otherwise_not(b.y[i][j],   c, 0)
        if b.y[i][j+1] <= -1:update_and_countup_otherwise_not(b.y[i][j+1], c, 0)
    if crosses == 4 - ctrl:
        if b.x[i][j]   <= -1:update_and_countup_otherwise_not(b.x[i][j],   c, 1)
        if b.x[i+1][j] <= -1:update_and_countup_otherwise_not(b.x[i+1][j], c, 1)
        if b.y[i][j]   <= -1:update_and_countup_otherwise_not(b.y[i][j],   c, 1)
        if b.y[i][j+1] <= -1:update_and_countup_otherwise_not(b.y[i][j+1], c, 1)
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
