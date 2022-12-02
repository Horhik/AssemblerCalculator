equation = input()

def get_max_foldness_coords(equation):
    max_foldness = 0
    curr_foldness = 0
    fold_founded = 0
    fold_x = 0
    fold_y = 0
    for i in range(0, len(equation)):
        if equation[i] == "(":
            curr_foldness += 1
            if max_foldness < curr_foldness:
                fold_x = i


                max_foldness = curr_foldness
                fold_founded = 1
        elif equation[i] == ")":
            curr_foldness -=1

            if fold_founded == 1:
                fold_y = i
                fold_founded = 0

        elif curr_foldness < 0:
            print("FUCK, YOU ARE LOOSER")
            exit(1)

    return(fold_x,fold_y+1)

def gen_new_equation(equation, x, y):
    begin=equation[slice(0,x)]
    res = str(eval(equation[slice(x,y)]))
    end  =equation[slice(y, len(equation))]


    return(begin + res + end)

def is_just_a_number(number):
    
    if number.replace('-','').isdigit():
        return(True)
    print("DIGIT", number)
    return False

def recursion(equation):

    equation = equation.replace(" ", "")
    if is_just_a_number(equation):
        print(equation)
        return(0)
        

    x, y = get_max_foldness_coords(equation)

    ans = (gen_new_equation(equation, x,y))
    print(ans)
    return(recursion(ans))

recursion(equation)
