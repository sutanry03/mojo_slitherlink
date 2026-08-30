from main import Board, update_and_countup_otherwise_not as u

struct Ring:
    var i1: Int
    var j1: Int
    var d1: Int
    var s1: Bool
    var i2: Int
    var j2: Int
    var d2: Int
    var s2: Bool
    var close: Int

    def __init__(out self, i1: Int, j1: Int, d1: Int, i2: Int, j2: Int, d2: Int) raises:
        self.i1 = i1
        self.j1 = j1
        self.d1 = d1
        self.s1 = False
        self.i2 = i2
        self.j2 = j2
        self.d2 = d2
        self.s2 = False
        self.close = 0
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
    for i in b.l["x"]:
        for j in i:
            if j == -1:
                # impl.
                continue
    b.b = c
    return b^
