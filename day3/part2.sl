
var in = bfdopen(0, O_READ);
var line = zmalloc(142);

var input = grnew();

var sum = bignew(0);
var ratio = bignew(0);
var nums;

var lastx;

var addnumber = func(x,y) {
    if (x < 0 || y < 0 || y >= grlen(input)) return 0;
    var line = grget(input, y);
    if (!isdigit(line[x])) return 0;
    while (x != 0 && isdigit(line[x-1])) {
        x--;
    };
    if (x == lastx) return 0;
    lastx = x;
    bigmulw(ratio, atoi(line+x));
    nums++;
    return 1;
};

var dir = [-1, 0, 1];
var symbol = func(x,y) {
    var dx = -1; var dy = -1;
    nums = 0;
    bigsetw(ratio, 1);
    while (dy != 2) {
        dx = -1;
        lastx = -1;
        while (dx != 2) {
            addnumber(x+dx,y+dy);
            dx++;
        };
        dy++;
    };
    if (nums == 2) {
        bigadd(sum, ratio);
    };
};

while(bgets(in, line, 142)) {
    line[strlen(line)-1] = 0;
    grpush(input, line);
    line = zmalloc(142);
};

var y = 0;
var x;
while (y < grlen(input)) {
    x = 0;
    line = grget(input, y);
    while (line[x]) {
        if (line[x] == '*') symbol(x,y);
        x++;
    };
    y++;
};

printf("%b\n", [sum]);
