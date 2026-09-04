from src.solve import Board, update_and_countup_otherwise_not as u, print_board
from src.signs.common import diagonal_neighbors, check_cell

def third(mut b: Board, i: Int, j: Int, x: Int, y: Int) raises-> Bool:
    if b.f[i][j]:
        return False
    # TODO: impl.
    var c: Bool = False

    # from diag
    var diag: Tuple[Int, Int, Int, Int] = diagonal_neighbors(b, i, j)

    if diag[0] == 0:
        u(b.x[i][j] ,c ,1)
        u(b.y[i][j+1] ,c ,1)
    if diag[1] == 0:
        u(b.x[i][j] ,c ,1)
        u(b.y[i][j] ,c ,1)
    if diag[2] == 0:
        u(b.x[i+1][j] ,c ,1)
        u(b.y[i][j] ,c ,1)
    if diag[3] == 0:
        u(b.x[i+1][j] ,c ,1)
        u(b.y[i][j+1] ,c ,1)

    if diag[0] in [1, -3]:
        u(b.x[i+1][j] ,c ,1)
        u(b.y[i][j] ,c ,1)
        if diag[0] == -3:
            if j < b.w - 1 and b.x[i][j+1] == -1:
                u(b.x[i][j+1] ,c ,0)
            if i != 0 and b.y[i-1][j+1] == -1:
                u(b.y[i-1][j+1] ,c ,0)
    if diag[1] in [1, -3]:
        u(b.x[i+1][j] ,c ,1)
        u(b.y[i][j+1] ,c ,1)
        if diag[1] == -3:
            if j != 0 and b.x[i][j-1] == -1:
                u(b.x[i][j-1] ,c ,0)
            if i != 0 and b.y[i-1][j] == -1:
                u(b.y[i-1][j] ,c ,0)
    if diag[2] in [1, -3]:
        u(b.x[i][j] ,c ,1)
        u(b.y[i][j+1] ,c ,1)
        if diag[2] == -3:
            if j != 0 and b.x[i+1][j-1] == -1:
                u(b.x[i+1][j-1] ,c ,0)
            if i < b.h-1 and b.y[i+1][j] == -1:
                u(b.y[i+1][j] ,c ,0)
    if diag[3] in [1, -3]:
        u(b.x[i][j] ,c ,1)
        u(b.y[i][j] ,c ,1)
        if diag[3] == -3:
            if j < b.w-1 and b.x[i+1][j+1] == -1:
                u(b.x[i+1][j+1] ,c ,0)
            if i < b.h-1 and b.y[i+1][j+1] == -1:
                u(b.y[i+1][j+1] ,c ,0)

    # 3-3pair
    if i != 0 and b.n[i-1][j] == 3:
        u(b.x[i-1][j], c, 1)
        u(b.x[i][j],   c, 1)
        u(b.x[i+1][j], c, 1)
        if j != 0:
            u(b.x[i][j-1], c, 0)
        if j != b.w - 1:
            u(b.x[i][j+1], c, 0)
    if i != b.h - 1 and b.n[i+1][j] == 3:
        u(b.x[i][j],   c, 1)
        u(b.x[i+1][j], c, 1)
        u(b.x[i+2][j], c, 1)
        if j != 0:
            u(b.x[i+1][j-1], c, 0)
        if j != b.w - 1:
            u(b.x[i+1][j+1], c, 0)
    if j != 0 and b.n[i][j-1] == 3:
        u(b.y[i][j-1], c, 1)
        u(b.y[i][j],   c, 1)
        u(b.y[i][j+1], c, 1)
        if i != 0:
            u(b.y[i-1][j], c, 0)
        if i != b.w - 1:
            u(b.y[i+1][j], c, 0)
    if j != b.w - 1 and b.n[i][j+1] == 3:
        u(b.y[i][j],   c, 1)
        u(b.y[i][j+1], c, 1)
        u(b.y[i][j+2], c, 1)
        if i != 0:
            u(b.y[i-1][j+1], c, 0)
        if i != b.h - 1:
            u(b.y[i+1][j+1], c, 0)

    # corner
    if x == 0 and y == 0:
        u(b.x[0][0], c, 1)
        u(b.y[0][0], c, 1)
    if x == 0 and y == 1:
        u(b.x[0][b.w-1], c, 1)
        u(b.y[0][b.w], c, 1)
    if x == 1 and y == 0:
        u(b.x[b.h][0], c, 1)
        u(b.y[b.h-1][0], c, 1)
    if x == 1 and y == 1:
        u(b.x[b.h][b.w-1], c, 1)
        u(b.y[b.h-1][b.w], c, 1)
    #

    var tf: Bool = check_cell(b, i, j, 3)
    c = (c or tf)

    # b.f[i][j] = True
    return c
