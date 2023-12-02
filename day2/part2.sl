
var in = bfdopen(0, O_READ);
var line = malloc(512);

var skipto = func(s, ch) {
    while (*s && *s != ch) s++;
    return s;
};

var big1 = bignew(0);
var result = bignew(0);

var possible = func(s) {
    var end;
    var comma;
    var count;
    var colour;
    var r = 0;
    var g = 0;
    var b = 0;
    while (1) {
        count = atoi(s);
        colour = skipto(s, ' ')+1;
        if (colour[0] == 'r' && count > r) r = count;
        if (colour[0] == 'g' && count > g) g = count;
        if (colour[0] == 'b' && count > b) b = count;
        comma = skipto(s, ',');
        end = skipto(s, ';');
        if (comma lt end) end = comma;
        if (!*end) break;
        s = end + 1;
        while (iswhite(*s)) s++;
    };
    bigsetw(big1, r);
    bigmulw(big1, g);
    bigmulw(big1, b);
    bigadd(result, big1);
};

# Game 1: 2 red, 3 blue; 4 red, 5 green
var s;
while (bgets(in, line, 512)) {
    s = skipto(line, ':') + 2;
    possible(s);
};
printf("%b\n", [result]);
