###
#Here are the requirements:

#2 players should be able to play the game (both sitting at the same computer)
#The board should be printed out every time a player makes a move
#You should be able to accept input of the player position and then place a symbol on the board

###


def user_in(board,value,mark):
    
    while int(value) not in check_choice :
        
        value = input('Mark your entry: ')
        
        if int(value) in check_choice:
            #will write later
            if board[value] == 'X' or board[value] == 'O':
                print('Already selected, Cant select here!')
                value = input('Mark your entry: ')
            else:   
                board[value] = mark
                
        else:
            print('Invalid Entry!')
        
def display(board):
    row1 = [board['7'],board['8'],board['9']]
    row2 = [board['4'],board['5'],board['6']]
    row3 = [board['1'],board['2'],board['3']]
       
    return print(f'{row1}\n{row2}\n{row3}')

def win_check(board,loop):
    a = [board['7'],board['8'],board['9']]
    b = [board['4'],board['5'],board['6']]
    c = [board['1'],board['2'],board['3']]
    c1 = [board['7'],board['4'],board['1']]
    c2 = [board['8'],board['5'],board['2']]
    c3 = [board['9'],board['6'],board['3']]
    d1 = [board['7'],board['5'],board['3']]
    d2 = [board['9'],board['5'],board['1']]
    
    if (a == ['X','X','X'] or c1 == ['X','X','X'] or d1 == ['X','X','X'] or b == ['X','X','X'] or c2 == ['X','X','X'] or d2 == ['X','X','X'] or c == ['X','X','X'] or c3 == ['X','X','X']):
        print('Player 2 win!')
      #  return p1 == True
        game_on = input('Play again? (Y or N)')
        return game_on
    
    elif (a == ['O','O','O'] or c1 == ['O','O','O'] or d1 == ['O','O','O'] or b == ['O','O','O'] or c2 == ['O','O','O'] or d2 == ['O','O','O'] or c == ['O','O','O'] or c3 == ['O','O','O']):
        print('Player 2 win!')
       # return p2 == True 
        game_on = input('Play again? (Y or N)')
        return game_on
    elif loop == 9:
    
        print('Draw!')
        game_on = input('Play again? (Y or N)')
        return game_on  
        
        
board = {'9':" ",'8':" ",'7':" ",'6':" ",'5':" ",'4':" ",'3':" ",'2':" ",'1':" "}
value = False
check_choice = list(range(1,10))
i = 1
game_on = 'Y'

while game_on.upper() == 'Y':
    
    
    print('Lets play!')
    while i < 10:
        if i in [1,3,5,7,9]:
            print('Player 1')
            user_in(board,value,'X')
            display(board)
            win_check(board,i)
            if game_on.upper() == 'N':
                print('THE END!')
                break
        else:
            print('Player 2')
            user_in(board,value,'O')
            display(board)
            win_check(board,i)
            if game_on.upper() == 'N':
                print('THE END!')
                break

        i += 1
        game_on.upper() == 'N'
    
