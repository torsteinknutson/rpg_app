################################################################################
#tredjepartsklienter:
#import os
import openai
openai.organization = "org-98WegjnciT8d9eM7vQu60LsS" #RPG_CORE (FREMTIND)

import os
from dotenv import load_dotenv

load_dotenv()

import tiktoken as tiktoken 
from functions import num_tokens_from_messages as num_tokens_from_messages


#egenlagde 
from prompt import prompt_1 as prompt_1
from prompt import prompt_2 as prompt_2
from prompt import prompt_3 as prompt_3
from prompt import prompt_4 as prompt_4
from prompt import system_1 as system_1
from prompt import prompt_ignore as prompt_ignore
from functions import num_tokens_from_messages as num_tokens_from_messages

################################################################################
def rb_func_1(user_input_x): # why is it promt 5??


    openai.api_key = os.getenv('OPEN_API_KEY')    

    #hent RPGLE-source fra fil (eksempel til bruk på systemet - må byttes ut med user_input i prompt message_list)
    with open(r'datoverk.rpgle', 'r') as f:
        code_getter = str(f.read())

    #rolle for AI. Kan være 'system', 'assistant', 'user'
    role='assistant'

#lag liste prompt-jsonl liste som skal sendes til AI.
    message_list = [
        {
            "role": role,
            "content": prompt_ignore + str(prompt_4) + str(user_input_x)   #+ code_getter
        }
    ]


    #regne på antall tokens sendt, antall max lovlig og antall max reply fra AI
    num_sent_tokens = num_tokens_from_messages(message_list)

    print('Tokens i send-msg: ' + str(num_tokens_from_messages(message_list)))
    max_allowed_tokens = 4095
    allowed_reply = max_allowed_tokens - num_sent_tokens
    print('Tokens ledig for svar: ', allowed_reply)
    if num_sent_tokens +1 > max_allowed_tokens:
        print('Antall send-tokens: ', num_sent_tokens, ' er over max: ', max_allowed_tokens,'!')


    print('Venter på resultater...')


    #AI 
    completion = openai.ChatCompletion.create(
        #model = 'text-davinci-003', 
        model = 'gpt-3.5-turbo-0301',
        #prompt = prompt_ignore + system_1 + prompt_1 + code_getter,
        messages = message_list,
        temperature = 0,
        max_tokens = allowed_reply,
        top_p = 0.3,
        #stream = True, 
        frequency_penalty = 0.0,
        presence_penalty = 0.0, 
        stop = ["\"\"\""]
        )

    response = completion["choices"][0]["message"]["content"]
    #print(response)


    #save response to file:
    with open(r'output.txt', 'w', encoding='utf-8') as f:
        f.write(response)
        f.close()

    #Flytt til pos8 for RPG
    with open(r'output.txt', 'r+') as f_in, open(r'rpgle3.rpgle', 'w') as f_out:
        lines = f_in.readlines()
        f_in.seek(0)
        for line in lines:
            f_out.write(' ' * 7 + line)
    return (response) 
    
