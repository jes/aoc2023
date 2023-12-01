
var in = bfdopen(0, O_READ);
var line = malloc(128);

var nums = ["zero", "one", "two", "three", "four", "five", "six",
"seven", "eight", "nine"];

var jesdigit = func(str, nump) {
    if (isdigit(*str)) {
        *nump = *str-'0';
        return 0;
    };
    var i = 0;
    while (nums[i]) {
        if (strncmp(str, nums[i], strlen(nums[i])) == 0) {
            *nump = i;
            return 0;
        };
        i++;
    };
};

var i = 0;
var first; var last;
var sum = bignew(0);
while (bgets(in, line, 128)) {
    i = 0;
    first = -1;
    while (line[i]) {
        if (first == -1) jesdigit(line+i, &first);
        jesdigit(line+i, &last);
        i++;
    };
    bigaddw(sum, mul(first,10)+last);
};
printf("%b\n", [sum]);
