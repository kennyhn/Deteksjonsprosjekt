function main
    %% Default values
    fprintf(['Welcome to the detection project'...
            ' created by Martin and Kenny\n']);
    while 1
        fprintf(['Choose which program (number) to run:\n'...
            '1. Problem 1\n'...
            '2. Problem 3\n'...
            '3. Problem 5\n'...
            '4. Problem 6\n'...
            '5. Problem 8\n'...
            '7. Exit\n']);
            
        userAnswer = input("Choose alternative (confirm with Enter): ");
        
        
        switch userAnswer
            case 1
                problem1_f
                userInput = input('Continue? (y/n): ', 's');
                switch userInput
                    case 'n'
                        break
                end
            case 2
                problem3_f
                userInput = input('Continue? (y/n): ', 's');
                switch userInput
                    case 'n'
                        break
                end
            case 3
                problem5_f
                userInput = input('Continue? (y/n): ', 's');
                switch userInput
                    case 'n'
                        break
                end
            case 4
                problem6_f
                userInput = input('Continue? (y/n): ', 's');
                switch userInput
                    case 'n'
                        break
                end
            case 5
                problem8_f
                userInput = input('Continue? (y/n): ', 's');
                switch userInput
                    case 'n'
                        break
                end
            case 7
                break
            otherwise
                fprintf('Choose a valid option\n')
        end
    end