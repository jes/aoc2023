
var in = bfdopen(0, O_READ);
var line = malloc(128);

var i = 0;
var first; var last;
var sum = bignew(0);
while (bgets(in, line, 128)) {
    i = 0;
    first = -1;
    while (line[i]) {
        if (isdigit(line[i]) && first==-1) first = line[i]-'0';
        if (isdigit(line[i])) last = line[i]-'0';
        i++;
    };
    bigaddw(sum, mul(first,10)+last);
};
printf("%b\n", [sum]);
