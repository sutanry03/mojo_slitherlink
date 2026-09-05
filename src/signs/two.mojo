from src.solve import Board, update_and_countup_otherwise_not as u, print_board
from src.signs.common import diagonal_neighbors, check_cell

def second(mut b: Board, i: Int, j: Int, x: Int, y: Int) raises-> Bool:
    if b.f[i][j]:
        return False
    # TODO: impl.
    var c: Bool = False

    # from diag
    var diag: Tuple[Int, Int, Int, Int] = diagonal_neighbors(b, i, j)

    if diag[0] == 2:
        u(b.x[i][j] ,c ,0)
        u(b.y[i][j] ,c ,1)
        u(b.x[i+1][j] ,c ,1)
        u(b.y[i][j+1] ,c ,0)
    if diag[1] == 2:
        u(b.x[i][j] ,c ,0)
        u(b.y[i][j] ,c ,0)
        u(b.x[i+1][j] ,c ,1)
        u(b.y[i][j+1] ,c ,1)
    if diag[2] == 2:
        u(b.x[i][j] ,c ,1)
        u(b.y[i][j] ,c ,0)
        u(b.x[i+1][j] ,c ,0)
        u(b.y[i][j+1] ,c ,1)
    if diag[3] == 2:
        u(b.x[i][j] ,c ,1)
        u(b.y[i][j] ,c ,1)
        u(b.x[i+1][j] ,c ,0)
        u(b.y[i][j+1] ,c ,0)

    if diag[0] == 1 or diag[2] == 1:
        if b.y[i][j+1] in [0,1]:u(b.x[i][j] ,c ,1-b.y[i][j+1])
        if b.x[i+1][j] in [0,1]:u(b.y[i][j] ,c ,1-b.x[i+1][j])
        if b.y[i][j]   in [0,1]:u(b.x[i+1][j] ,c ,1-b.y[i][j])
        if b.x[i][j]   in [0,1]:u(b.y[i][j+1] ,c ,1-b.x[i][j])
        # interpolate diag
        if diag[0] in [-3,-1]:
            if i == 0:    u(b.x[i][j+1], c, 1)
            if j == b.w-1:u(b.y[i-1][j+1], c, 1)
        if diag[2] in [-3,-1]:
            if i == b.h-1:u(b.x[i+1][j-1], c, 1)
            if j == 0:    u(b.y[i+1][j], c, 1)
    if diag[1] == 1 or diag[3] == 1:
        if b.y[i][j]   in [0,1]:u(b.x[i][j], c, 1-b.y[i][j])
        if b.x[i][j]   in [0,1]:u(b.y[i][j], c, 1-b.x[i][j])
        if b.y[i][j+1] in [0,1]:u(b.x[i+1][j], c, 1-b.y[i][j+1])
        if b.x[i+1][j] in [0,1]:u(b.y[i][j+1], c, 1-b.x[i+1][j])
        # interpolate diag
        if diag[1] in [-3,-1]:
            if i == 0:u(b.x[i][j-1], c, 1)
            if j == 0:u(b.y[i-1][j], c, 1)
        if diag[3] in [-3,-1]:
            if i == b.h-1:u(b.x[i+1][j+1], c, 1)
            if j == b.w-1:u(b.y[i+1][j+1], c, 1)

    if diag[0] == -3 and (b.x[i+1][j] == 0 or b.y[i][j] == 0):
        if b.x[i][j+1]   <= -1:u(b.x[i][j+1],   c, 0)
        if b.y[i-1][j+1] <= -1:u(b.y[i-1][j+1], c, 0)
        if b.x[i+1][j] <= -1:u(b.x[i+1][j], c, 1)
        if b.y[i][j]   <= -1:u(b.y[i][j],   c, 1)
    if diag[1] == -3 and (b.x[i+1][j] == 0 or b.y[i][j+1] == 0):
        if b.x[i][j-1] <= -1:u(b.x[i][j-1], c, 0)
        if b.y[i-1][j] <= -1:u(b.y[i-1][j], c, 0)
        if b.x[i+1][j] <= -1:u(b.x[i+1][j], c, 1)
        if b.y[i][j+1] <= -1:u(b.y[i][j+1], c, 1)
    if diag[2] == -3 and (b.x[i][j] == 0 or b.y[i][j+1] == 0):
        if b.x[i+1][j-1] <= -1:u(b.x[i+1][j-1], c, 0)
        if b.y[i+1][j]   <= -1:u(b.y[i+1][j],   c, 0)
        if b.x[i][j]   <= -1:u(b.x[i][j],   c, 1)
        if b.y[i][j+1] <= -1:u(b.y[i][j+1], c, 1)
    if diag[3] == -3 and (b.x[i][j] == 0 or b.y[i][j] == 0):
        if b.x[i+1][j+1] <= -1:u(b.x[i+1][j+1], c, 0)
        if b.y[i+1][j+1] <= -1:u(b.y[i+1][j+1], c, 0)
        if b.x[i][j] <= -1:u(b.x[i][j], c, 1)
        if b.y[i][j] <= -1:u(b.y[i][j], c, 1)



    var tf: Bool = check_cell(b, i, j, 2)
    c = (c or tf)
    # b.f[i][j] = True
    return c
