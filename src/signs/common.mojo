from src.solve import Board, update_and_countup_otherwise_not as u

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
        if b.x[i][j]   <= -1:u(b.x[i][j],   c, 0)
        if b.x[i+1][j] <= -1:u(b.x[i+1][j], c, 0)
        if b.y[i][j]   <= -1:u(b.y[i][j],   c, 0)
        if b.y[i][j+1] <= -1:u(b.y[i][j+1], c, 0)
    if crosses == 4 - ctrl:
        if b.x[i][j]   <= -1:u(b.x[i][j],   c, 1)
        if b.x[i+1][j] <= -1:u(b.x[i+1][j], c, 1)
        if b.y[i][j]   <= -1:u(b.y[i][j],   c, 1)
        if b.y[i][j+1] <= -1:u(b.y[i][j+1], c, 1)
    return c

def diagonal_neighbors(mut b: Board, i: Int, j: Int) raises -> Tuple[Int, Int, Int, Int]:
    # check inteface btw diagonally across numbers
    var convert: Dict[Tuple[Int, Int], Int] = {
        (-1, -1):-2, (-1,0):-1, (-1,1):-3,
        (0,0):0, (0,1):1, (1,1):2,
        (-2, -2):-2, (-2,-1):-2, (-2,0):-1, (-2,1):-3
    }

    var diag: List[Int] = []
    # 1. NE
    diag.append(0 if j == b.w-1 else b.x[i][j+1])
    diag.append(0 if i == 0     else b.y[i-1][j+1])
    sort(diag)
    var NE: Int = convert[(diag[0], diag[1])]
    diag.clear()

    # 2. NW
    diag.append(0 if j == 0     else b.x[i][j-1])
    diag.append(0 if i == 0     else b.y[i-1][j])
    sort(diag)
    var NW: Int = convert[(diag[0], diag[1])]
    diag.clear()

    # 3. SW
    diag.append(0 if j == 0     else b.x[i+1][j-1])
    diag.append(0 if i == b.h-1 else b.y[i+1][j])
    sort(diag)
    var SW: Int = convert[(diag[0], diag[1])]
    diag.clear()

    # 4.SE
    diag.append(0 if j == b.w-1 else b.x[i+1][j+1])
    diag.append(0 if i == b.h-1 else b.y[i+1][j+1])
    sort(diag)
    var SE: Int = convert[(diag[0], diag[1])]
    diag.clear()

    return (NE, NW, SW, SE)
