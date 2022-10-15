package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"time"
)

type Players struct {
	name string
	dice int
}

type DicePlay struct {
	name string
	dice []int
}

func game(n int, m int) {
	fmt.Println("Start Game with ", n, " player & ", m, " dice")
	var score map[string]int
	score = map[string]int{}

	player := setupPlayer(n, m)
	for _, x := range player {
		score[x.name] = 0
	}

	play(1, player, score)
	// fmt.Println("Player ", player)
	// fmt.Println("Score ", score)
}

func play(number int, player []Players, score map[string]int) {
	dicePlay := dicePlay(player)
	// fmt.Println("dicePlay ", dicePlay)

	fmt.Println("===========================")
	fmt.Println("===========================")
	fmt.Println("##Lempar dadu: ", number)

	for _, x := range dicePlay {
		fmt.Print(x.name, "(", score[x.name], "):")
		for _, dice := range x.dice {
			fmt.Print(dice, ", ")
		}
		fmt.Println("")
	}

	evaluate := evaluate(dicePlay)
	// fmt.Println("evaluate ", evaluate)
	// // new Evaluate
	for key, row := range dicePlay {
		for _, dice := range row.dice {
			if dice == 1 {
				newKey := key + 1
				if newKey >= len(dicePlay) {
					var s = evaluate[0].dice
					s = append(s, 1)
				} else {
					var s = evaluate[key+1].dice
					s = append(s, 1)
				}
			}
			if dice == 6 {
				score[row.name] += 1
			}
		}
	}

	fmt.Println("##Setelah evaluasi: ")

	for _, row := range evaluate {
		fmt.Print(row.name, "(", score[row.name], "):")
		for _, dice := range row.dice {
			fmt.Print(dice, ", ")
		}
		fmt.Println("")
	}

	// //new player
	player = newPlayer(evaluate)
	// fmt.Println("newPlayer", player)
	newPlayer := make([]Players, 0)
	for _, row := range player {
		// if($row['dadu'] == 0) {
		// 	unset($player[$key]);
		// }
		if row.dice > 0 {
			newPlayer = append(newPlayer, Players{
				name: row.name,
				dice: row.dice,
			})
		}
		// for _, newP := range newPlayer {
		// 	fmt.Println("NEW PLAYER NAME ***", newP.name)
		// 	fmt.Println("NEW PLAYER DICE ***", newP.dice)
		// }
		// fmt.Println("COUNT NEW PLAYER", len(newPlayer))
	}
	player = newPlayer

	if len(player) <= 1 {
		fmt.Println("===========================")
		fmt.Println("##FINISH")
		fmt.Println("##SCORE")
		fmt.Println(score)
		var winn string
		temp := 1
		for key, row := range score {
			if row > temp {
				winn = key + " dengan score " + strconv.Itoa(row)
				temp = row
			}
		}
		fmt.Println("**************************************************")
		fmt.Print("##WINNER ***** ", winn, " *****")
		fmt.Println("")
		fmt.Println("**************************************************")
		return
	}

	if len(player) >= 1 {
		// if number <= 10 {
		rand.Seed(time.Now().UTC().UnixNano())
		play(number+1, player, score)
	}
}

func newPlayer(result []DicePlay) []Players {
	data := make([]Players, 0)
	for _, row := range result {
		data = append(data, Players{
			name: row.name,
			dice: len(row.dice),
		})
	}
	return data
}

func evaluate(dicePlay []DicePlay) []DicePlay {
	data := make([]DicePlay, 0)
	for _, row := range dicePlay {
		var newDice []int
		for _, dice := range row.dice {
			if dice != 6 && dice != 1 {
				newDice = append(newDice, dice)
			}
		}
		data = append(data, DicePlay{
			name: row.name,
			dice: newDice,
		})
	}
	return data
}

func dicePlay(player []Players) []DicePlay {
	data := make([]DicePlay, 0)
	for _, row := range player {
		data = append(data, DicePlay{
			name: row.name,
			dice: diceProcess(row.dice),
			// dice: make([]int, 0),
		})
	}
	return data
}

func diceProcess(dice int) []int {
	var data []int
	// fmt.Println("********************************", rand.Intn(7-1)+1)
	for i := 1; i <= dice; i++ {
		data = append(data, rand.Intn(7-1)+1)
	}
	return data
}

func setupPlayer(player int, dice int) []Players {
	data := make([]Players, 0)
	for i := 0; i < player; i++ {
		data = append(data, Players{
			name: "Pemain#" + strconv.Itoa(i+1),
			dice: dice,
		})
	}
	return data
}

func main() {
	game(3, 4)
}
