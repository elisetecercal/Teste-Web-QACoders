import random
import string
from faker import Faker

fake = Faker()

# Lista de primeiros nomes que começam com "A"
first_names_with_a = [
    "Alice","André","Augusto", "Amanda", "Alexander", "Aaron", "Ava", "Abigail", "Adrian", "Aiden", "Amelia", "Adélia", "Andressa", "Alberto", "Antonio", "Alexandre", "Amadeu", "Ataide", "Agenor", "Alex","Adauto"
]

def generate_user_data():
    first_name = random.choice(first_names_with_a)
    last_name = fake.last_name()

    senha_gerada = f"Alea@{random.randint(1000, 9999)}"

    return {
        'Nome': first_name,
        'NomeCompletoUsuario': f"{first_name} {last_name}",
        'EmailUsuario': fake.email(),
        'PerfilDeAcessoUsuario': 'ADMIN',
        'CPFUsuario': ''.join([str(random.randint(0, 9)) for _ in range(11)]),
        'SenhaUsuario': senha_gerada,
        'ConfirmeSenhaUsuario': senha_gerada  # Utiliza a mesma senha gerada
    }

PreencheFormularioUsuario = generate_user_data()

# Função para gerar dados de usuário com nome e sobrenome com iniciais minúsculas
def generate_user_data_minusculo():
    first_name = random.choice(first_names_with_a).lower()  # Gera o primeiro nome e coloca em minúscula
    last_name = fake.last_name().lower()  # Gera o sobrenome e coloca em minúscula

    senha_gerada = f"Alea@{random.randint(1000, 9999)}"

    return {

        'NomeCompletoUsuarioMinusculo': f"{first_name} {last_name}",  # Certifique-se de que a chave é essa

    }
# Variável que armazena Nome Completo iniciais minusculas para o campo Nome Completo
PreencheFormularioUsuarioMinusculo = generate_user_data_minusculo()

# Gera uma string contendo letras, números e caracteres especiais
def gerar_nome_com_caracteres_invalidos():
    # Nome e Sobrenome válidos gerados pelo Faker
    first_name = fake.first_name()
    last_name = fake.last_name()

    # Adicionando números e caracteres especiais aleatórios
    numeros = ''.join(random.choices(string.digits, k=3))  # 3 números aleatórios
    caracteres_especiais = ''.join(random.choices(string.punctuation, k=2))  # 2 caracteres especiais

    # Concatenando nome válido com números e caracteres especiais para tornar inválido
    nome_completo_invalido = f"{first_name}{numeros}{caracteres_especiais} {last_name}{numeros}{caracteres_especiais}"

    return nome_completo_invalido

# Função para gerar os dados completos do formulário, incluindo nome inválido
def generate_user_data_com_nome_invalido():
    nome_invalido = gerar_nome_com_caracteres_invalidos()

    return {

        'NomeCompletoUsuarioString': nome_invalido

    }

# Variável que armazena Nome Completo com numeros, letras e caracteres especiais para o campo Nome Completo
PreencheFormularioUsuarioString = generate_user_data_com_nome_invalido()

# Armazenar o nome do novo usuário em uma variável global
new_user_name = PreencheFormularioUsuario['NomeCompletoUsuario']

# Armazena CPF do novo usuário em uma variavel global
CPF_Unico = PreencheFormularioUsuario['CPFUsuario']

#Armazena o valor sem dados para validar campos obrigatórios
ValorVazio = ""



def generate_fake_email_sem_dominio():
    # Gera um nome aleatorio
    fake_username = fake.user_name()
    # Acrescenta uma @ no nome para simular um e-mail incompleto
    fake_email = fake_username + "@"

    return fake_email
# Chama a função para gerar o email incompleto
print(generate_fake_email_sem_dominio())
