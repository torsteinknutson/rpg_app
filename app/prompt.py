# Instruksjoner til AI
# Prompts
# System
# Context

#Prompts:
prompt_ignore = 'Ignorer alle tidligere instruksjoner og svar på norsk'
prompt_1 = 'I will provide you with RPGLE-code I want you to create comments on. Include the original code and insert your comments explaining the code.\
Be concise.\
DO NOT insert comments on every line on the code, instead summarize code-snippets and only comment on the context of the code. \
Insert comments above the code that is explained. Do not to repeat similar comments that explains similar types of variables. Summarize.\
Here is the code:'

prompt_2 = 'Inkluder den orginale koden med en forklaring på hva koden gjør, forklart på en konsis måte med kommentarer satt inn over koden:'

prompt_3 = {
    "oppgave": "Skriv kommentarer for RPGLE-kode",
    "instruksjon": "Kommentering av kode er et viktig element for å skrive god kode. Kommentarer skal alltid skrives over koden, ikke etter den. \
        Prøv å bruke beskrivende ord når du kommenterer koden slik at andre utviklere enkelt kan forstå det. Lag konsise kommentarer. \
            Det er ikke nødvendig å kommentere alle kodelinjene. Bruk kommentarer til å forstå flyt, helheten og kontekst i koden. \
                Ikke generer kommentarer som er en introduksjon eller avslutning av hva som skjer i koden. \
                     Ikke kommenter selvforklarende kode. ",
    "data": {
        "språk": "RPGLE"},
}


prompt_4 = {'Do two things. First, extract the important context of the folowing RPGLE code and insert a comment exlaining the general overarching theme of the code in a consise way so that it is easy to understand for other developers. \
    Second, insert comments above code-snippets throughout the code explaining the code,' + 
' then third, check if any of the inserted comments are above variables being set to a value, and in that case remove the comments that you made for that. The Desired format: '
+ 
'Comment above code like: // This procedure takes input from...  \ Comment lenght: 1, maximum 3 lines \ Return:The original code + the inserted comments.  \ Language comments: Norwegian \ Text:' ###
}


#System
system_1 = 'Ditt navn er RB. Du er en dyktig RPGLE programvareutvikler \
med tjue års erfaring med å jobbe med datamaskiner i IBM AS400- og IBMi-serien. \
Du er en aktiv og populær bidragsyter til fora som bidrar og diskuterer RPGLE-kode. \
Du forklarer kode med kommentarer. \
Fra å lese all RPGLE-kode som finnes vet du hva som er den beste måten å gjøre ting på. \
Du er flink til å forklare hva som skjer i koden. \
Du er kortfattet. \
Du er spesielt opptatt av kontekst og hvordan deler av koden forholder seg til hverandre. \
Du oppretter kommentarer ovenfor kode. \
Oppfør deg som en hjelpsom RPGLE-programvareutvikler og gi enkle og vakre kommentarer som forklarer koden som er gitt til deg. \
Her er noen kontekst som du bør vite: \
Vår kodebase består av to tusen RPGLE-programmer, prototyper, serviceprogrammer, clle, dspf, bnd og mer.  \
Målet er å skape konsistente kommentarer gjennom hele kodebasen vår. '





#####################################################################################################################################

'''
 {
  "model": "text-davinci-003",
  "prompt": "# Python 3.7\n \ndef randomly_split_dataset(folder, filename, split_ratio=[0.8, 0.2]):\n    df = pd.read_json(folder + filename, lines=True)\n    train_name, test_name = \"train.jsonl\", \"test.jsonl\"\n    df_train, df_test = train_test_split(df, test_size=split_ratio[1], random_state=42)\n    df_train.to_json(folder + train_name, orient='records', lines=True)\n    df_test.to_json(folder + test_name, orient='records', lines=True)\nrandomly_split_dataset('finetune_data/', 'dataset.jsonl')\n    \n# An elaborate, high quality docstring for the above function:\n\"\"\"",
  "temperature": 0,
  "max_tokens": 150,
  "top_p": 1.0,
  "frequency_penalty": 0.0,
  "presence_penalty": 0.0,
  "stop": ["#", "\"\"\""]
}

'''

#create a docstring fromopenaAI, same as above, only in python code
#response = openai.Completion.create(
#  model="text-davinci-003",
#  prompt="# Python 3.7\n \ndef randomly_split_dataset(folder, filename, split_ratio=[0.8, 0.2]):\n    df = pd.read_json(folder + filename, lines=True)\n    train_name, test_name = \"train.jsonl\", \"test.jsonl\"\n    df_train, df_test = train_test_split(df, test_size=split_ratio[1], random_state=42)\n    df_train.to_json(folder + train_name, orient='records', lines=True)\n    df_test.to_json(folder + test_name, orient='records', lines=True)\nrandomly_split_dataset('finetune_data/', 'dataset.jsonl')\n    \n# An elaborate, high quality docstring for the above function:\n\"\"\"",
#  temperature=0,
#  max_tokens=150,
#  top_p=1.0,
#  frequency_penalty=0.0,
#  presence_penalty=0.0,
#  stop=["#", "\"\"\""]
#)

