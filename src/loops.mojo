from src.solve import Board, update_and_countup_otherwise_not as u

struct Ring(Copyable, Equatable):
    var w: Int
    var i1: Int
    var j1: Int
    var d1: Int
    var i2: Int
    var j2: Int
    var d2: Int
    var close: Int

    def __init__(out self, w: Int, i1: Int, j1: Int, d1: Int, i2: Int, j2: Int, d2: Int) raises:
        self.w = w
        self.i1 = i1
        self.j1 = j1
        self.d1 = d1
        self.i2 = i2
        self.j2 = j2
        self.d2 = d2
        self.close = 0 #just initialize
        self.close = self.check_connection()

    def __eq__(self, ot: Self) -> Bool:
        var s1 = self.i1 * self.w + self.j1
        var s2 = self.i2 * self.w + self.j2
        var t1 = ot.i1 * ot.w + ot.j1
        var t2 = ot.i2 * ot.w + ot.j2
        return min(s1,s2) == min(t1,t2) and  max(s1,s2) == max(t1,t2)

    def check_connection(self) raises -> Int:
        """ Return an Integer indicates direction when both edge are nearest neighbor each other."""
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
        全てのb.xとb.yに対してどのリングに所属するか明らかにし, b.lに記録する.
        同時にリングリストb.rを管理する. リングを伸ばせる時に延長するのが目的.
        b.lが既存で始まる場合, それらの延伸から行う.
    """
    var c: Bool = False

    def extend_ring(b: Board, mut ti: Int, mut tj: Int, mut td: Int) -> Bool:
        if td == 1:
            if tj < b.w and b.x[ti][tj] == 1:
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
            if ti < b.h and b.y[ti][tj] == 1:
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

    # initialy extend exisiting rings and reflesh linup
    var newlist: List[Ring] = []
    for i in range(len(b.r)):
        var init1: Tuple[Int, Int] = (b.r[i].i1, b.r[i].j1)
        var init2: Tuple[Int, Int] = (b.r[i].i2, b.r[i].j2)

        while True:
            var judge = extend_ring(b, b.r[i].i1, b.r[i].j1, b.r[i].d1)
            if judge: break
            if init1 == (b.r[i].i1, b.r[i].j1):
                b.r[i].i2 = b.r[i].i1
                b.r[i].j2 = b.r[i].j1
                break
        while True:
            var judge = extend_ring(b, b.r[i].i2, b.r[i].j2, b.r[i].d2)
            if judge: break
            if init2 == (b.r[i].i2, b.r[i].j2):
                b.r[i].i1 = b.r[i].i2
                b.r[i].j1 = b.r[i].j2
                break
        b.r[i].close = b.r[i].check_connection()
        if b.r[i].close == 5:
            print("LOOPED.")
            return b^
        #_ListIter[...].Element does not need to be fixed.
        if all([b.r[i] != newone for newone in newlist]):
            newlist.append(Ring(
                b.r[i].w, b.r[i].i1, b.r[i].j1, b.r[i].d1,
                b.r[i].i2, b.r[i].j2, b.r[i].d2
            ))
    b.r = newlist^

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
                var result: Ring = Ring(b.w, ti1, tj1, td1, ti2, tj2, td2)
                for n, r in enumerate(b.r):
                    # in ver 1.0, "_ListIter[...] .Element" does NOT NEED to be fixed despite the LSP error.
                    if result != r:
                        continue
                    else:
                        b.l["x"][i][j] = n
                        break
                else:
                    b.l["x"][i][j] = len(b.r)
                    b.r.append(result^)
                    c = True

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
                var result: Ring = Ring(b.w, ti1, tj1, td1, ti2, tj2, td2)
                for n, r in enumerate(b.r):
                    if result != r:
                        continue
                    else:
                        b.l["y"][i][j] = n
                        break
                else:
                    b.l["y"][i][j] = len(b.r)
                    b.r.append(result^)
                    c = True

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
            var result: Ring = Ring(b.w, ti1, tj1, td1, ti2, tj2, td2)
            for n, r in enumerate(b.r):
                if result != r:
                    continue
                else:
                    b.l["y"][i][b.w] = n
                    break
            else:
                b.l["y"][i][b.w] = len(b.r)
                b.r.append(result^)
                c = True

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
            var result: Ring = Ring(b.w, ti1, tj1, td1, ti2, tj2, td2)
            for n, r in enumerate(b.r):
                if result != r:
                    continue
                else:
                    b.l["x"][b.h][j] = n
                    break
            else:
                b.l["x"][b.h][j] = len(b.r)
                b.r.append(result^)
                c = True

    for i in range(len(b.r)):
        var cc: Int = b.r[i].close
        if cc == 1 and b.x[b.r[i].i1][min(b.r[i].j1, b.r[i].j2)] == -1:
            u(b.x[b.r[i].i1][min(b.r[i].j1, b.r[i].j2)], c, 0)
        if cc == 2 and b.y[min(b.r[i].i1, b.r[i].i2)][b.r[i].j1] == -1:
            u(b.y[min(b.r[i].i1, b.r[i].i2)][b.r[i].j1], c, 0)
        if cc == 3 and b.x[b.r[i].i1][min(b.r[i].j1, b.r[i].j2)] == -1:
            u(b.x[b.r[i].i1][min(b.r[i].j1, b.r[i].j2)], c, 0)
        if cc == 4 and b.y[min(b.r[i].i1, b.r[i].i2)][b.r[i].j1] == -1:
            u(b.y[min(b.r[i].i1, b.r[i].i2)][b.r[i].j1], c, 0)
    b.b = c
    return b^
