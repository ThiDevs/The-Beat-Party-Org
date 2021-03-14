import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use a service account
cred = credentials.Certificate("C:\\Users\\Thiago\\Downloads\\the-beat-party-firebase-adminsdk-q0fri-ac26f54448.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref = db.collection(u'User')
docs = users_ref.stream()
linha ='Nome;Cpf;Sexo;Tipo de Ingresso;Login;' + '\n'
for doc in docs:
    print(f'{doc.id} => {doc.to_dict()}')
    sexo = 'Feminino'
    if doc.to_dict()['Sexo'] == '0' :
        sexo = 'Masculino'
    
    tipoingresso = 'Pré-Venda'
    
    if doc.to_dict()['TipoIngresso'] == '3':
        tipoingresso = "Combo"
    elif doc.to_dict()['TipoIngresso'] == '2':
        tipoingresso = "Normal"
 
    linha += doc.to_dict()['Nome'] + ';' + doc.to_dict()['Cpf'] + ';' + sexo + ';' + tipoingresso + ';' + doc.to_dict()['Login'] + '\n' 

open('lista', 'w').write(linha)