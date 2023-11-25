import json
from random import randint, random

NAMES = [ 'Hannah Macmillan', 'Ellamae Wardle', 'Leonila Holbrook', 'June Dougherty', 'Basilia Schur', 'Jennefer Cathcart', 'Mathilda Gervasi', 'Anneliese Yardley', 'Ozie Wigfall', 'Renita Camille' ]
# 10 | From http://listofrandomnames.com/index.cfm?generated
LOJAS = [ 'Aveiro', 'Coimbra', 'Lisboa', 'Porto' ]
SECCOES = [ 'Peixaria', 'Talho', 'Charcutaria', 'Frutaria', 'Roupa', 'Bricolage', 'Padaria' ]
PRODUTOS = {
    'Pao': 0.25,
    'Sumol': 1.25,
    'Oreo': 0.99,
    'Macas': 0.99,
    'Cerveja': 0.67,
    'Feijao': 1.76,
    'Gelado': 2.53,
}

def randomTime():
    return f'2020-{randint(1,12):02}-{randint(1,28):02}T{randint(0,23):02}:{randint(0,59):02}:{randint(0,59):02}.000+0000'

IDS = []
def randomId():
    while True:
        n = randint(1000, 9999)
        if n in IDS:
            continue

        IDS.append(n)
        return n        

CLIENTS = []


# Create 10 clients
for n in NAMES:
    nif = randint(100000000, 999999999)
    client = {
        'nif': nif,
        'nome': n,
        'lojas': [x for x in LOJAS if random() > 0.5]
    }
    CLIENTS.append(client)
    if len(client['lojas']) == 0:
        client['lojas'] = LOJAS[randint(0, len(LOJAS)-1)]

    print(f"INSERT INTO clientes JSON '{json.dumps(client)}';")

    for loja in client['lojas']:
        clientloja = {
            'nif': nif,
            'nome': n,
            'loja': loja
        }
        print(f"INSERT INTO clientes_loja JSON '{json.dumps(clientloja)}';")

print("\n\n\n")

# Create 2 to 5 help requests foreach client, at a random section and store
# Eache one has between 2 to 10 messages
for c in CLIENTS:
    for i in range(0, randint(2, 5)):
        ajuda = {
            'id': randomId(),
            'loja': c['lojas'][randint(0, len(c['lojas'])-1)],
            'seccao': SECCOES[randint(0, len(SECCOES)-1)],
            'nifcliente': c['nif'],
            'mensagens': [f'Loren ipsum {i}...' for i in range(randint(2, 10))],
            'momento': randomTime()
        }

        print(f"INSERT INTO ajudas JSON '{json.dumps(ajuda)}';")

print("\n\n\n")

# Create 2 to 5 transactions foreach client, at a random store
# Each one has between 2 to 10 random products
for c in CLIENTS:
    for i in range(0, randint(2, 5)):
        t = {
            'id': randomId(),
            'nifcliente': c['nif'],
            'loja': c['lojas'][randint(0, len(c['lojas'])-1)],
            'caixa': randint(1, 5),
            'momento': randomTime(),
            'produtos': {p: v for p, v in PRODUTOS.items() if random() > 0.5},
            'valor': 0
        }
        if len(t['produtos']) == 0:
            p = list(PRODUTOS.items())[randint(0, len(PRODUTOS)-1)]
            t['produtos'] = {p[0]: p[1]}

        t['valor'] = sum(v for v in t['produtos'].values())

        print(f"INSERT INTO transacoes JSON '{json.dumps(t)}';")

