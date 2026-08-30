from main import Board, update_and_countup_otherwise_not as u

struct Ring:
    var i1: Int
    var j1: Int
    var d1: Int
    var i2: Int
    var j2: Int
    var d2: Int
    var close: Int

    def __init__(out self, i1: Int, j1: Int, d1: Int, i2: Int, j2: Int, d2: Int) raises:
        self.i1 = i1
        self.j1 = j1
        self.d1 = d1
        self.i2 = i2
        self.j2 = j2
        self.d2 = d2
        self.close = 0 #just initialize
        self.close = self.check_connection()

    def check_connection(self) raises -> Int:
        """ return an Integer indicates direction when both edge are nearest neighbor each other."""
        if abs(self.i1 - self.i2) > 1 or abs(self.j1 - self.j2) > 1:
            return 0
        var di: Int = self.i2 - self.i1
        var dj: Int = self.j2 - self.j1
        # 0:afar, 1:East(i,j = 0,1), 2:North, 3:West, 4:South (from edge1), 5:same(error)
        return {
            -1: {-1:0, 0:2, 1:0},
            0:  {-1:3, 0:5, 1:1},
            1:  {-1:0, 0:4, 1:0}
        }[di][dj]

def simple_loops(var b: Board) raises -> Board:
    """
        全てのb.xとb.yに対してどのリングに所属するか明らかにし, b.rに記録する.
        同時にリングリストを管理する. リングを伸ばせる時に延長するのが目的.
    """
    var c: Bool = False

    def extend_ring(b: Board, mut ti: Int, mut tj: Int, mut td: Int) -> Bool:
        if td == 1:
            if tj < b.w-1 and b.x[ti][tj+1] == 1:
                tj += 1
                return False
            if ti != 0 and b.y[ti-1][tj] == 1:
                ti -= 1
                td = 2
                return False
            if ti < b.h and b.y[ti][tj] == 1:
                ti += 1
                td = 4
                return False
        if td == 2:
            if ti != 0 and b.y[ti-1][tj] == 1:
                ti -= 1
                return False
            if tj != 0 and b.x[ti][tj-1] == 1:
                tj -= 1
                td = 3
                return False
            if tj < b.w and b.x[ti][tj] == 1:
                tj += 1
                td = 1
                return False
        if td == 3:
            if tj != 0 and b.x[ti][tj-1] == 1:
                tj -= 1
                return False
            if ti != 0 and b.y[ti-1][tj] == 1:
                ti -= 1
                td = 2
                return False
            if ti < b.h and b.y[ti][tj] == 1:
                ti += 1
                td = 4
                return False
        if td == 4:
            if ti < b.h-1 and b.y[ti+1][tj] == 1:
                ti += 1
                return False
            if tj != 0 and b.x[ti][tj-1] == 1:
                tj -= 1
                td = 3
                return False
            if tj < b.w and b.x[ti][tj] == 1:
                tj += 1
                td = 1
                return False
        return True

    var ti1: Int
    var tj1: Int
    var td1: Int
    var ti2: Int
    var tj2: Int
    var td2: Int
    # without edges
    for i in range(b.h):
        for j in range(b.w):
            # almost of horizaontal(x)
            if b.x[i][j] == 1 and b.l["x"][i][j] == -1:
                ti1, tj1, td1 = i, j+1, 1
                ti2, tj2, td2 = i, j, 3
                while True:
                    var judge = extend_ring(b, ti1, tj1, td1)
                    if judge: break
                while True:
                    var judge = extend_ring(b, ti2, tj2, td2)
                    if judge: break
                b.l["y"][i][j] = len(b.r)
                b.r.append(Ring(ti1, tj1, td1, ti2, tj2, td2))

            # almost of vertical(y)
            if b.y[i][j] == 1 and b.l["y"][i][j] == -1:
                ti1, tj1, td1 = i, j, 2
                ti2, tj2, td2 = i+1, j, 4
                while True:
                    var judge = extend_ring(b, ti1, tj1, td1)
                    if judge: break
                while True:
                    var judge = extend_ring(b, ti2, tj2, td2)
                    if judge: break
                b.l["y"][i][j] = len(b.r)
                b.r.append(Ring(ti1, tj1, td1, ti2, tj2, td2))

        # y_rightests
        if b.y[i][b.w] == 1 and b.l["y"][i][b.w] == -1:
            ti1, tj1, td1 = i, b.w, 2
            ti2, tj2, td2 = i+1, b.w, 4
            while True:
                var judge = extend_ring(b, ti1, tj1, td1)
                if judge: break
            while True:
                var judge = extend_ring(b, ti2, tj2, td2)
                if judge: break
            b.l["y"][i][b.w] = len(b.r)
            b.r.append(Ring(ti1, tj1, td1, ti2, tj2, td2))

    # x_bottoms
    for j in range(b.w):
        if b.x[b.h][j] == 1 and b.l["x"][b.h][j] == -1:
            ti1, tj1, td1 = b.h, j, 3
            ti2, tj2, td2 = b.h, j+1, 1
            while True:
                var judge = extend_ring(b, ti1, tj1, td1)
                if judge: break
            while True:
                var judge = extend_ring(b, ti2, tj2, td2)
                if judge: break
            b.l["x"][b.h][j] = len(b.r)
            b.r.append(Ring(ti1, tj1, td1, ti2, tj2, td2))

    b.b = c

    for i in range(len(b.r)):
        print(b.r[i].i1, b.r[i].j1, b.r[i].d1, b.r[i].i2, b.r[i].j2, b.r[i].d2)
        # TODO: reject not unique ones
    return b^
