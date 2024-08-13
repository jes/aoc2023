package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Range struct {
	Min uint64
	Max uint64
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	line := scanner.Text()
	parts := strings.Split(line, " ")
	seeds := make([]Range, 0)
	for i := 1; i < len(parts); i += 2 {
		n, _ := strconv.ParseInt(parts[i], 10, 64)
		m, _ := strconv.ParseInt(parts[i+1], 10, 64)
		seeds = append(seeds, Range{Min: uint64(n), Max: uint64(n + m - 1)})
	}

	scanner.Scan() // blank line

	nums := seeds

	for scanner.Scan() { // header line
		theMap := make([][]uint64, 0)
		for scanner.Scan() { // actual line
			line := scanner.Text()
			parts := strings.Split(line, " ")
			if len(parts) < 3 {
				break
			}
			m := make([]uint64, 0)
			for _, v := range parts {
				i, _ := strconv.ParseInt(v, 10, 64)
				m = append(m, uint64(i))
			}
			theMap = append(theMap, m)
		}
		fmt.Println(nums)
		newNums := make([]Range, 0)
		for _, r := range nums {
			ns := mapAccordingly(r, theMap)
			newNums = append(newNums, ns...)
		}
		nums = newNums
	}

	fmt.Println(nums)
	smallest := nums[0].Min
	for _, n := range nums {
		if n.Min < smallest {
			smallest = n.Min
		}
	}
	fmt.Println(smallest)

}

func mapAccordingly(r Range, theMap [][]uint64) []Range {
	outNums := make([]Range, 0)
	for i, m := range theMap {
		outStart := m[0]
		inStart := m[1]
		length := m[2]
		inMin := inStart
		inMax := inStart + length - 1
		if r.Max < inMin || r.Min > inMax {
			// entire range is outside this map, do nothing
		} else if r.Min >= inMin && r.Max <= inMax {
			// entire range is inside this map, map the whole thing and return it
			outNums = append(outNums, Range{
				Min: r.Min - inStart + outStart,
				Max: r.Max - inStart + outStart,
			})
			return outNums
		} else if r.Min < inMin {
			// split out the part of the range before the map
			ns := mapAccordingly(Range{Min: inMin, Max: r.Max}, theMap[i:])
			outNums = append(outNums, ns...)
			r.Max = inMin - 1
		} else if r.Max > inMax {
			// split out the part of the range after the map
			ns := mapAccordingly(Range{Min: r.Min, Max: inMax}, theMap[i:])
			outNums = append(outNums, ns...)
			r.Min = inMax + 1
		} else {
			fmt.Fprintf(os.Stderr, "unconsidered case: (%d,%d) mapped by (%d,%d)\n", r.Min, r.Max, inMin, inMax)
		}

	}
	outNums = append(outNums, r)
	return outNums
}
