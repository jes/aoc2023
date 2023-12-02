
var in = bfdopen(0, O_READ);
var line = malloc(128);

var skipto = func(s, ch) {
    while (*s && *s != ch) s++;
    return s;
};

var possible = func(s) {
    var end;
    var comma;
    var space;
    var count;
    var colour;
    while (1) {
        count = atoi(s);
        colour = skipto(s, ' ')+1;
        if (colour[0] == 'r' && count > 12) return 0;
        if (colour[0] == 'g' && count > 13) return 0;
        if (colour[0] == 'b' && count > 14) return 0;
        comma = skipto(s, ',');
        end = skipto(s, ';');
        if (comma < end) end = comma;
        if (!*end) return 1;
        s = end + 1;
        while (iswhite(*s)) s++;
    };
};

# Game 1: 2 red, 3 blue; 4 red, 5 green
var id;
var s;
var sum = 0;
while (bgets(in, line, 128)) {
    id = atoi(line+5);
    s = skipto(line, ':') + 2;
    if (possible(s)) sum = sum + id;
};
printf("%d\n", [sum]);
