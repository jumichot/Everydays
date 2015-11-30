package main

import "fmt"

type Saiyan struct {
	Name   string
	Power  int
	Father *Saiyan
}

func (s *Saiyan) Lol() {
	s.Power += 233
}

func main() {
	goku := &Saiyan{"Goku", 9000, nil}
	Super(goku)
	goku.Lol()
	gohan := &Saiyan{
		Name:  "Gohan",
		Power: 1000,
		Father: &Saiyan{
			Name: "Goku", Power: 9001, Father: nil,
		}}
	fmt.Println(goku.Power)
	fmt.Println(gohan)
	fmt.Println(*gohan)
}
func Super(s *Saiyan) {
	s.Power = 223
}
