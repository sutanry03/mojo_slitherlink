from main import Board, update_and_countup_otherwise_not

def simple_points(var b: Board) raises -> Board:
    var cnt: Bool = False
    for i in range(b.h+1):
        var yedge: Int
        if i % b.h:
            yedge = -1
        else:
            yedge = i // b.h
        for j in range(b.w+1):
            var xedge: Int
            if j % b.w:
                xedge = -1
            else:
                xedge = j // b.w
            var temp: Bool = treat_vertex(b, i, j, xedge, yedge)
            cnt = cnt or temp
    if cnt:
        b.b = True
        print("Iteration (points) begin.")
        b = simple_points(b^)
    return b^

def treat_vertex(mut b: Board, i: Int, j: Int, x: Int, y: Int) -> Bool:
    var c: Bool = False
    var lines: Int = 0
    var crosses: Int = 0

    if x in [0, 1]:
        crosses += 1
    if x in [1, -1]:
        if b.x[i][j-1] == 1:lines += 1
        if b.x[i][j-1] == 0:crosses += 1
    if x in [0, -1]:
        if b.x[i][j] == 1:lines += 1
        if b.x[i][j] == 0:crosses += 1
    if y in [0, 1]:
        crosses += 1
    if y in [1, -1]:
        if b.y[i-1][j] == 1:lines += 1
        if b.y[i-1][j] == 0:crosses += 1
    if y in [0, -1]:
        if b.y[i][j] == 1:lines += 1
        if b.y[i][j] == 0:crosses += 1
    # print(i, j, lines, crosses)

    if lines == 2:
        if x != 0 and b.x[i][j-1] <= -1:update_and_countup_otherwise_not(b.x[i][j-1], c, 0)
        if y != 0 and b.y[i-1][j] <= -1:update_and_countup_otherwise_not(b.y[i-1][j], c, 0)
        if x != 1 and b.x[i][j]   <= -1:update_and_countup_otherwise_not(b.x[i][j],   c, 0)
        if y != 1 and b.y[i][j]   <= -1:update_and_countup_otherwise_not(b.y[i][j],   c, 0)
    elif lines == 1 and crosses == 2:
        if x != 0 and b.x[i][j-1] <= -1:update_and_countup_otherwise_not(b.x[i][j-1], c, 1)
        if y != 0 and b.y[i-1][j] <= -1:update_and_countup_otherwise_not(b.y[i-1][j], c, 1)
        if x != 1 and b.x[i][j]   <= -1:update_and_countup_otherwise_not(b.x[i][j],   c, 1)
        if y != 1 and b.y[i][j]   <= -1:update_and_countup_otherwise_not(b.y[i][j],   c, 1)
    elif crosses == 2:
        if x != 0 and b.x[i][j-1] == -1:update_and_countup_otherwise_not(b.x[i][j-1], c, -2)
        if y != 0 and b.y[i-1][j] == -1:update_and_countup_otherwise_not(b.y[i-1][j], c, -2)
        if x != 1 and b.x[i][j]   == -1:update_and_countup_otherwise_not(b.x[i][j],   c, -2)
        if y != 1 and b.y[i][j]   == -1:update_and_countup_otherwise_not(b.y[i][j],   c, -2)
    elif crosses == 3:
        if x != 0 and b.x[i][j-1] <= -1:update_and_countup_otherwise_not(b.x[i][j-1], c, 0)
        if y != 0 and b.y[i-1][j] <= -1:update_and_countup_otherwise_not(b.y[i-1][j], c, 0)
        if x != 1 and b.x[i][j]   <= -1:update_and_countup_otherwise_not(b.x[i][j],   c, 0)
        if y != 1 and b.y[i][j]   <= -1:update_and_countup_otherwise_not(b.y[i][j],   c, 0)
    return c
