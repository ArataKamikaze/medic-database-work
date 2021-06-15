#!/usr/bin/env python
# coding: utf-8

# ## Importando pacotes

# In[1]:


import numpy as np
import datetime
import pandas as pd
from dateutil.relativedelta import relativedelta
import io


# ## Conectar ao banco de dados

# In[2]:


import mysql.connector

config = {
  'user': 'root',
  'password': '',
  'host': '127.0.0.1',
  'database': 'hospital',
  'raise_on_warnings': True,
  'port': 3308
}

cnx = mysql.connector.connect(**config)


# ## Criando função para inserir

# In[3]:


cursor = cnx.cursor()
def inserirDados(relacao, colunas, valores):
    add = "insert into " + relacao + " (" + ', '.join(colunas) + ")" + "values ("+ "%s," * (len(colunas) - 1) +"%s);"
    for linha in valores:
        cursor.execute(add, list(linha))


# ## Criando funçãoes do numpy

# In[4]:


def textoParaDataTimeFunc(texto):
    partes = [int(x) for x in texto.split("/")]
    return datetime.datetime(partes[2], partes[1], partes[0])

def arrumarTelefoneFunc(tel):
    if(tel.startswith("+")):
        tel = tel[4:]
    
    if(tel.startswith('(')):
        tel = tel[4:]
        
    if(len(tel) == 15):
        tel = tel[:-1]
    return tel

def removerFrescurasFunc(dado):
    result = ""
    
    for caractere in dado:
        if caractere.isdigit():
            result += caractere
    return int(result)


# In[5]:


arrendondarParaInteiro = np.frompyfunc(lambda x: int(round(x)), 1, 1)
arrendondarCom2 = np.frompyfunc(lambda x: float(round(x,2)), 1, 1)
agruparData = np.frompyfunc(lambda dia, mes, ano: datetime.datetime(ano, mes, dia), 3, 1)
converterInteiro = np.frompyfunc(lambda x: int(x),1,1)
stringParaDataTime = np.frompyfunc(textoParaDataTimeFunc,1,1)
arrumarTelefone = np.frompyfunc(arrumarTelefoneFunc,1,1)
arrumarTempo = np.frompyfunc(lambda x: datetime.time(x // 60, x % 60),1,1)
arrumarFrescuras = np.frompyfunc(removerFrescurasFunc,1,1)


# ## Inserindo dados do arquivo

# In[6]:


with io.open('dados_variados.sql', 'r', encoding="utf-8") as arquivo:
    comandos = arquivo.read().split("$$")
    
    for comando in comandos:
        cursor.execute(comando)


# # Inserir doenças

# In[7]:


doencas = [
    "Asma",
    "Bronquite",
    "Enfisema pulmonar",
    "Hipertensão",
    "Insuficiência cardíaca",
    "Diabetes",
    "Depressão",
    "Alcolismo",
    "Parkinson",
    "Alzheimer"
]

doencas = np.array(doencas).reshape(-1,1)

inserirDados("doenca", ["nome"], doencas)


# # Inserir tipo de residência médica

# In[8]:


residencias=[
    "Acupuntura",
    "Alergia e Imunologia",
    "Anestesiologia",
    "Angiologia",
    "Oncologia",
    "Cardiologia",
    "Cirugia cardiovascular",
    "Cirugia da mão",
    "Cirugia de cabeça e pescoço",
    "Cirugia Geral",
    "Cirugia o aparelho digestivo",
    "Cirugia pediátrica",
    "Cirugia plástica",
    "Cirugia torácica",
    "Clínica médica",
    "Coloproctologia",
    "Dermatologia",
    "Endocrinologia",
    "Endoscopia",
    "Gastroenterologia",
    "Genética médica",
    "Geriatria",
    "Ginecologia e obstetríca",
    "Hematologia",
    "Homeopatia",
    "Infectologia",
    "Mastologia",
    "Nefrologia",
    "Neurocirurgia",
    "Neurologia",
    "Nutrologia",
    "Oftalmologia",
    "Ortopedia",
    "Otorrinolaringologia",
    "Patologia",
    "Patologia Clínica",
    "Pediatria",
    "Pneumologia",
    "Psiquiatria",
    "Radiologia",
    "Radioterapia",
    "Reumatologia",
    "Urologia"
]

residencias = np.array(residencias).reshape(-1,1)

inserirDados("tipo_de_residencia_medica", ["nome"], residencias)


# ## Inserindo planos de saúde

# In[9]:


plano_de_saude = [
    "Amil",
    "Avimed",
    "Samcil",
    "Blue life",
    "Omint",
    "Prevent Senior",
    "Serma",
    "Dix saúde",
    "GreenLine",
    "Sim",
    "amesp",
    "Itálica",
    "Intermédica",
    "Porto seguro",
    "Santamália",
    "Unimed",
    "SulAmérica",
    "Medial saúde",
    "Bradesco Saúde",
    "Saúde é tudo",
    "Oral Pró",
    "DentalPar",
    "Green Card"
]

planos_de_saude = np.stack([plano_de_saude, np.random.randint(100000, 999999, size=len(plano_de_saude))], axis=1)

inserirDados("Plano_de_saude", ["nome", "registro"], planos_de_saude)


# In[10]:


planos_de_saude


# ## especialidade

# especialidades = [
#     "imunologia",
#     "Anestesiologia",
#     "Cardiologia",
#     "Cirurgia geral",
#     "Clínica médica",
#     "Dermatologia",
#     "Endocrinologia",
#     "Endoscopia",
#     "Gastroenterologia",
#     "Geriatria",
#     "Ginecologia",
#     "Hematologia",
#     "Infectologia",
#     "Neurologia",
#     "Nutrologia",
#     "Oftalmologia",
#     "Oncologia",
#     "Ortopedia"
# ]
# 
# especialidades = np.array(especialidades).reshape(-1,1)
# 
# inserirDados("especialidade", ["nome"], especialidades)

# ## Pessoas

# In[11]:


base = pd.read_json("pessoas.json")
n = base.shape[0]
base.loc[round(n * 21/100):round(n * 54/100),"estado_civil"] = "Solteiro(a)"
base["data_de_nascimento"] = stringParaDataTime(base["data_de_nascimento"])
base["numero_do_telefone"] = arrumarTelefone(base["numero_do_telefone"])
base['complemento'] = np.random.randint(1,300,size=n)
base.loc[base["estado_civil"] == "Divorciado","estado_civil"] = "Divorciado(a)"
base.loc[base["estado_civil"] == "Separado","estado_civil"] = "Separado(a)"
base["cpf"] = arrumarFrescuras(base["cpf"])
base["cep"] = arrumarFrescuras(base["cep"])

inserirDados('pessoa',base.columns, base.values)


# Criando data de nascimento:
# 
# livre, exceto entre os (n * 21/100) e n * (51 / 100)

# 10% de funcionários
#      10% (1% do global) de medicos funcionários
#      
# 11% de medicos prestadores de serviço
# 
# 33% de depedentes (média 2 por funcionários)
# 
#      tem uma interseção entre clientes e depedentes
#      
# 50% de clientes
# 
# Como os cpfs foram gerados aleatóriamente:
# 
# \[0, n * 10/100\]: funcionários
# 
# \[0, n * 1/100\]: medicos funcionários
# 
# \]n * 10/100, n * 21/100]: medicos prestadores de serviço
# 
# \]n * 21/100, n * 54/100\]: depedentes
# 
# \[n * 50/100, n\]: clientes

# In[12]:


cpfs = base['cpf'].values
funcionarios_CPF = cpfs[0:round(n * 10/100)]
medicos_funcionarios_CPF = cpfs[0:round(n * 1/100)]
medicos_prestadores_de_servico_CPF = cpfs[round(n * 10/100):round(n * 21/100)]
depedentes_CPF = cpfs[round(n * 21/100):round(n * 54/100)]
clientes_CPF = cpfs[round(n * 50/100):]


# ## Gerar funcionarios
# 
# data_de_adminissao
# 
#     ano: distribuição normal
#         
#         média: 2010
#         
#         desvio padrão: 5
#        
#     mês e dia: homogênio
#         
# salario_bruto
#     
#     distribuição normal
#     
#         média: 2261
#         
#         desvio padrão: 500
# CPF

# In[13]:


funcionario_tamanho = len(funcionarios_CPF)

ano = np.random.normal(loc=2010, scale=5, size=(funcionario_tamanho))
ano = arrendondarParaInteiro(ano)
dia = np.random.randint(1,29, size=(funcionario_tamanho))
mes = np.random.randint(1,13, size=(funcionario_tamanho))
data_de_adminissao = agruparData(dia,mes,ano)


# ### Funcao

# In[14]:


cargos = [
    ["Medico", 226100],
    ["Técnico de enfermagem", 173668],
    ["Enfermeiro", 338368],
    ["Recepcionista geral", 129866],
    ["Auxiliar de escritório", 146218],
    ["Recepcionista de consultório", 130217],
    ["Auxiliar de enfermagem", 175739],
    ["Assistente administrativo", 161850]
]



inserirDados("funcao", ["nome"], np.stack(cargos, axis=1)[0].reshape(-1,1))


# In[15]:


#nomes = np.repeat(id_atual, len(medicos_funcionarios_CPF))

parte_tamanho = funcionario_tamanho//len(cargos)
resto = funcionario_tamanho % len(cargos)

ids = np.array([],dtype=int)
salarios = np.array([],dtype=int)

for i, (cargo_nome, cargo_salario_medio) in enumerate(cargos):
    tamanho_atual = parte_tamanho
    
    if i < resto:
        tamanho_atual += 1
        
    ids = np.concatenate([ids, np.repeat(i+1, tamanho_atual).astype(int)])
    salarios = np.concatenate([
        salarios,
        arrendondarParaInteiro(np.random.normal(loc=cargo_salario_medio, scale=cargo_salario_medio*0.1, size=tamanho_atual))
    ])


# In[16]:


funcionario_tamanho = len(funcionarios_CPF)
salario = converterInteiro(np.random.normal(loc=226100, scale=50000, size=(funcionario_tamanho)))
funcionario = np.stack([funcionarios_CPF,ids,salarios, data_de_adminissao], axis=1)
inserirDados("Funcionario", ["CPF","funcao_id","salario_bruto","data_de_adminissao"], funcionario)


# ## Gerando depedentes
# número de depedentes x funcionário
# minimo: 0
# máximo: 6
# média: 3
# 
# n = 6
# 
# E\[X\] = 2 = 4 * 0.5
# p = 0.5

# ## Inserindo depedentes

# In[17]:


depedentes_tamanho = len(depedentes_CPF)
total = 0
depedente_aux = 0
sql = "insert into depedentes(CPF, CPF_depedente) values (%s,%s);"

for func in funcionarios_CPF:
    atual = int(np.random.binomial(n=6,p=0.5))
    
    total = total + atual
    if(total > depedentes_tamanho):
        break
        
    for _ in range(atual):
        cursor.execute(sql, [int(func), int(depedentes_CPF[depedente_aux])])
        depedente_aux = depedente_aux + 1


# ## Inserindo cliente

# In[18]:


inserirDados("Cliente", ["CPF"], converterInteiro(clientes_CPF).reshape(-1,1))


# ## doencas_pre_existentes
# A probabilidade de um cliente ter uma doença é imdepedente de outra doença
# 
# Cada ganhará um número aleatório
# 
# doencas_pre_existentes(doenca_id, CPF)

# In[19]:


doencaTamanho = len(doencas)

probabilidades = [np.random.rand() for _ in doencas]

sql = "insert into doencas_pre_existentes(doenca_id, CPF) values (%s,%s);"

for cliente in clientes_CPF:
    for aux, probabilidade in enumerate(probabilidades):
        sorteado = np.random.rand();
        
        if(probabilidade > sorteado):
            cursor.execute(sql, [aux, int(cliente)])


# ## cliente_plano_de_saude

# In[20]:


plano_de_saude_tamanho = len(plano_de_saude)

probabilidades = [np.random.rand()/4 for _ in plano_de_saude]

sql = "insert into cliente_plano_de_saude(CPF, plano_de_saude_id) values (%s,%s);"

for cliente in clientes_CPF:
    for aux, probabilidade in enumerate(probabilidades):
        sorteado = np.random.rand();
        
        if(probabilidade > sorteado):
            cursor.execute(sql, [int(cliente), aux+2])


# ## Medico (teste)
# (CRM, escola_de_origem, tipo_de_residencia_medica_id)

# In[21]:


len("Universidade Federal Dos Vales Do Jequitinhonha E Mucuri (UFVJM)")


# In[22]:


escolas = ['Universidade Federal De Viçosa (UFV)',
 'Pontifícia Universidade Católica Do Rio Grande Do Sul (PUCRS)',
 'Universidade Federal Dos Vales Do Jequitinhonha E Mucuri (UFVJM)',
 'Universidade Federal De Minas Gerais (UFMG)',
 'Universidade Federal De Mato Grosso (UFMT)',
 'Universidade Federal Do Ceará (UFC)',
 'Universidade Federal De Mato Grosso (UFMT)',
 'Universidade Federal Da Paraíba (UFPB)',
 'Universidade De Pernambuco (UPE)',
 'Universidade Estadual Paulista Júlio De Mesquita Filho (UNESP)',
 'Universidade Estadual De Maringá (UEM)',
 'Faculdade De Medicina De São José Do Rio Preto (FAMERP)',
 'Universidade Federal De São Carlos (UFSCAR)',
 'Universidade Positivo (UP)',
 'Universidade Federal Do Rio Grande Do Norte (UFRN)']

tamanho_medico = len(medicos_funcionarios_CPF) + len(medicos_prestadores_de_servico_CPF)
tamanho_residencia = len(residencias)
np.random.randint(0,tamanho_residencia+1, size=tamanho_medico)
CRM = np.random.randint(300,234556,size=tamanho_medico,dtype="i")
medicos = np.stack([CRM,np.random.randint(1,tamanho_residencia + 1, size=(tamanho_medico)), np.random.choice(escolas, size=tamanho_medico)],axis=1)

inserirDados('Medico', ['CRM', 'tipo_de_residencia_medica_id','escola_de_origem'], medicos)


# ## Medico_funcionario
# Medico_funcionario(CRM, CPF)

# In[23]:


medicos_funcionarios_completo = np.stack([medicos_funcionarios_CPF, CRM[:medicos_funcionarios_CPF.shape[0]]],axis=1)
inserirDados('Medico_funcionario', ['CPF', 'CRM'], converterInteiro(medicos_funcionarios_completo))


# ## Medico_Prestador_de_Servico
# (CRM, CPF)

# In[24]:


medicos_prestador_de_servico = np.stack([medicos_prestadores_de_servico_CPF, CRM[medicos_funcionarios_CPF.shape[0]:medicos_funcionarios_CPF.shape[0] + medicos_prestadores_de_servico_CPF.shape[0]]],axis=1)
inserirDados('Medico_Prestador_de_Servico', ['CPF', 'CRM'], converterInteiro(medicos_prestador_de_servico))


# ## medico_plano_de_saude
# (plano_de_saude_id, CRM)

# In[25]:


plano_de_saude_tamanho = len(plano_de_saude)

probabilidades = [np.random.rand() for _ in plano_de_saude]
crms = np.stack(medicos, axis=1)[0]

sql = "insert into medico_plano_de_saude(plano_de_saude_id, CRM) values (%s,%s);"

for crm in crms:
    for aux, probabilidade in enumerate(probabilidades):
        sorteado = np.random.rand();
        
        if(probabilidade > sorteado):
            cursor.execute(sql, [aux+2, int(crm)])


# ## medico_especialidade
# (CRM, especialidade_id)

# In[26]:


tamanho_especialidade = 106

probabilidades = [np.random.rand()/6 for _ in range(tamanho_especialidade)]

sql = "insert into medico_especialidade(especialidade_id, CRM) values (%s,%s);"

for crm in crms:
    for aux, probabilidade in enumerate(probabilidades):
        sorteado = np.random.rand();
        
        if(probabilidade > sorteado):
            cursor.execute(sql, [aux, int(crm)])


# ## Gerar tipo_de_atendimento_aleatorio
# ex: Remorção de sisos
# fazer assim:
# um array para verbos
# um array para substantivos
# 
# Horas esperada: média: 0, tem 0.2 de chanche de somar 1
# 
# Efeitos colaterais:
# 
# Tipo_de_atendimento(nome, duracao_esperada, efeitos_colaterais, efeitos_colaterais)

# In[27]:


verbos = ["Remorção", "Transplante", "Analise", "Cura"]

substantivos = ["dos braços", "das pernas", "dos olhos", "da língua"]

efeitos_colaterais = ['Alergia',
 'insônia',
 'náusea',
 'Suor',
 'excessivo',
 'tremor',
 'falta de apetite,',
 'diarreia',
 'sonolência',
 'fadiga',
 'boca seca',
 'ansiedade']

nomes = []
for verbo in verbos:
    for substantivo in substantivos:
        nomes.append(verbo + " " + substantivo)
        
n = len(nomes)

tempoEsperado = arrumarTempo(np.random.randint(200,size=n))


efeitos_colaterais_lista = []

for _ in range(n):
    efeitos_colaterais_lista.append(",\n".join(np.random.choice(efeitos_colaterais, size=np.random.randint(len(efeitos_colaterais)))))

precos = arrendondarCom2(np.random.normal(loc=50000, scale=10000,size=n))

tipos_atendimentos = np.stack([nomes, tempoEsperado, efeitos_colaterais_lista, precos], axis=1)

inserirDados("Tipo_de_atendimento", ["nome", "duracao_esperada", "efeitos_colaterais", "preco"], tipos_atendimentos)


# ## plano_de_saude_tipo_de_atendimento
# 20%, 50%, 90%
# (plano_de_saude_id, tipo_de_atendimento_id, desconto)

# In[28]:


sql = "insert into plano_de_saude_tipo_de_atendimento(plano_de_saude_id, tipo_de_atendimento_id, desconto) values (%s,%s,%s);"
tipos_atendimentos_tamanho = tipos_atendimentos.shape[0]

arr = [round(tipos_atendimentos_tamanho * x) for x in [0.3, 0.5, 0.9]]

for plano_de_saude in range(plano_de_saude_tamanho):
    tipos_atendimentos_escolhidos = np.random.choice(range(tipos_atendimentos_tamanho), replace=False, size=np.random.choice(arr))+1
    
    for escolhido in tipos_atendimentos_escolhidos:
        desconto = int(np.random.randint(100))
        cursor.execute(sql,[int(plano_de_saude)+2, int(escolhido),desconto])


# ## Gerar tipo_de_tratamento aleatório
# numero_esperado_de_atendimentos: n = 4, p = 0.5

# substantivos = ["Terapia", "Medicamento", "Conversa", "Xingamento"]
# 
# adjetivos = ["quantica", "espacial", "vampirista", "taxista", "gorda"]
# 
# nomes = []
# for substantivo in substantivos:
#     for adjetivo in adjetivos:
#         nomes.append(substantivo + " " + adjetivo)
# 
# n = len(nomes)
# numero_esperados = np.random.binomial(n=4,p=0.5,size=n)
# precos = arrendondarCom2(np.random.normal(loc=500, scale=100,size=n))
# 
# eh_cronico = np.random.choice([0,1],size=n)
# 
# tipo_de_tratamento = np.stack([numero_esperados, eh_cronico, nomes],axis=1)
# 
# inserirDados("Tipo_de_tratamento", ["numero_esperados_de_atendimentos", "eh_cronico", "nome"], tipo_de_tratamento)

# ## Gerar atendimento_esperado

# In[29]:


from collections import Counter
sql = "insert into atendimento_esperado(tipo_de_tratamento_id, tipo_de_atendimento_id, quantidade) values (%s,%s,%s);"
n = 29
numero_esperados = np.random.binomial(n=4,p=0.5,size=n)
for tratamento, numero_esperado in enumerate(numero_esperados):
    atentimentos = np.random.randint(tipos_atendimentos.shape[0],size=numero_esperado)
    
    atentimentos=Counter(atentimentos)
    
    for a,b in atentimentos.items():
        cursor.execute(sql, [int(tratamento)+1, int(a) + 1,b])


# ## Gerar compete
# 
# Cada especialidade, ter 1, 2 ou 3 coisas
# randint(3) \[ 0, 2\]
# 

# sql = "insert into compete(especialidade_id, tipo_de_atendimento_id) values (%s,%s);"
# for i in range(len(especialidades)):
#     quant = np.random.randint(1, 4)
#     
#     for _ in range(quant):
#         temp = np.random.randint(1,len(tipos_atendimentos)+1)
#         cursor.execute(sql,[i, temp])

# ## tratamento
# Tratamento
# tipo_de_tratamento_id
# cpf

# In[30]:


tratamento_tamanho = 100
cpfs_tratamentos = np.random.choice(clientes_CPF, size=tratamento_tamanho)
tipo_de_tratamento_id = converterInteiro(np.random.randint(tipos_atendimentos.shape[0], size=tratamento_tamanho) + 1)

tratamentos = np.stack([tipo_de_tratamento_id, cpfs_tratamentos], axis=1)
inserirDados('tratamento', ['tipo_de_tratamento_id','cpf'], tratamentos)


# ## Atendimento
# (crm, plano_de_saude_id, tipo_de_atendimento_id, tratamento_id)
# 
# O plano de saude deve ser a intersecção entre cliente, médico e tipo_de_atendimento
# 
# A especialidade do médico deve ser compativel com tipo_de_atendimento
# 
# Para cada tratamento, pelo menos um atendimento, média 4, máximo 8 (binomial)
# 
# estado
# sala
# horario_inicio_real
# horario_fim_real
# horario_agendado
# 
# horário_agendado:
#     ano: distribuição normal
# 
#     média: 2010
# 
#     desvio padrão: 5
#     
#     min: 8
#     max: 20
#     00 ou 30
#     
#     para não bugar, no máximo 19:30
#     
# Horario_inicio_real:
#     atraso:
#     0 min (90%)
#     30min (9%)
#     2h (1%)

# ## Informacao_de_pagamento
# tipos_atendimentos = np.stack([nomes, tempoEsperado, efeitos_colaterais_lista, precos], axis=1)
# 
# valor
# 
# comissao_da_clinica
# 
# data_de_recebimento
# 
# valor_recebidos_por_medico
# 
# data_do_reparse_ao_medico
# 
# imposto_retido
# 
# 
# O valor é o valor do tipo de atendimento
# 
# Se o médico é prestador de serviço:
# 
#     comissao_da_clinica = valor * 30%
#         
#     valor_recebidos_por_medico = valor * 65%
#     
# Se o médico é funcionário
# 
#     comissao_da_clinica = valor * 95%
#     
#     valor_recebidos_por_medico = 0
#     
# imposto_retido = valor * 5%
# 
# #### datas de recebimento e data de repasse
# datas de recebimento: 30 dias antes ou depois do agendado, se for maior que o agora, deixar null
# 
# data de repasse: apenas quando data de recimento tem valor, uma semana depois dele

# In[31]:


cursor.execute("truncate atendimento")


# In[32]:


consulta_validos = "select distinct CRM, tipo_de_atendimento_id, plano_de_saude_id, tratamento_id from medico_especialidade join (select especialidade_id, B.tipo_de_atendimento_id,  plano_de_saude_id, tratamento_id from compete join ( select tipo_de_atendimento_id, A.plano_de_saude_id, tratamento_id from plano_de_saude_tipo_de_atendimento join ( select tratamento_id, plano_de_saude_id from cliente_plano_de_saude join Tratamento using(CPF))  as A using(plano_de_saude_id)) as B using (tipo_de_atendimento_id)) as C using (especialidade_id) where plano_de_saude_id in (select plano_de_saude_id from medico_plano_de_saude as D where D.CRM = CRM);"

cursor.execute(consulta_validos)
validos = cursor.fetchall()

data = pd.DataFrame(validos)
data.columns = ['CRM', 'tipo_de_atendimento_id', 'plano_de_saude_id', 'tratamento_id']

salas=["C66","E9","B43","A79","B29","B61","E49","E39","B32","C25","C31","C34","E20","D83","C81","C98","D4","E20","E7","E57","C92","B79","C27","C54","B65","D26","A39","A98","D22","E95","E9","E20","E18","B42","E12","E43","A73","A69","C25","D49","E78","A20","E7","B26","C97","E69","E77","B91","A50","D11","D37","C87","C18","B17","D33","B66","A77","C50","B84","C70","C25","D57","C46","B65","B23","B62","A42","C77","B15","A53","A28","E6","C14","D47","E64","C54","D92","A3","D59","B77","C88","A33","E0","E72","D72","B58","E0","E29","A34","D20","C22","C27","A85","D19","C61","C55","B70","A37","B1","E39"]

agora = datetime.datetime.now()
seis_meses_atras = datetime.datetime.now() + relativedelta(months=-6)

sql1= "select exists (select * from medico_funcionario where CRM = %s) from dual;"
sql2= "SELECT preco FROM tipo_de_atendimento where tipo_de_atendimento_id = %s;"
sql3 = "SELECT desconto FROM plano_de_saude_tipo_de_atendimento where plano_de_saude_id = %s and tipo_de_atendimento_id = %s;"
sql4 = "select eh_cronico from tipo_de_tratamento join tratamento using(tipo_de_tratamento_id) where tratamento_id = %s"


# clientes em tratamentos crônicos com agendamento pendente
quant_especial = 10;

for tratamento_id in range(1, tratamento_tamanho+1):
    
    candidatos = data.loc[data['tratamento_id'] == tratamento_id].values
    quant = np.random.binomial(n=10, p=0.5)
    
    cursor.execute(sql4,[int(tratamento_id)])
    eh_cronico = cursor.fetchall()[0][0]
    
    especial = False
    
    if quant_especial > 0 and eh_cronico == 1:
                quant_especial -= 1
                especial = True
    
    if candidatos.shape[0] > 0:
        selecionados = candidatos[np.random.randint(candidatos.shape[0], size=quant)]    
    
        for CRM, tipo_de_atendimento_id, plano_de_saude_id, _ in selecionados:
            sala = np.random.choice(salas)

            estado = 0

            if especial:
                 horario_agendado = seis_meses_atras + datetime.timedelta(days=np.random.randint(1,10))

            else:
                ano = np.random.binomial(n=2,p=0.6) + 2019
                dia = np.random.randint(1,29)
                mes = np.random.randint(1,13)
                hora = np.random.randint(8,20)
                minuto = np.random.choice([0, 30])
                horario_agendado = datetime.datetime(ano, mes, dia, hora, minuto)

                if(horario_agendado > agora):
                    estado = 1
                    horario_agendado = datetime.datetime(2021, mes, dia, hora, minuto)

            horario_inicio_real = None
            horario_fim_real = None

            if estado == 1:
                atraso = np.random.choice([datetime.timedelta(), datetime.timedelta(minutes=30), datetime.timedelta(hours=2)], p=[0.9,0.09,0.01])
                horario_inicio_real = horario_agendado + atraso

                horario_fim_real = horario_agendado + datetime.timedelta(hours=tempoEsperado[tipo_de_atendimento_id-1].hour, minutes=tempoEsperado[tipo_de_atendimento_id-1].minute) + atraso + np.random.choice([datetime.timedelta(), datetime.timedelta(minutes=30), datetime.timedelta(hours=2)], p=[0.9,0.09,0.01])

            # CRM, tipo_de_atendimento_id

            cursor.execute(sql1,[int(CRM)])
            eh_funcionario = cursor.fetchall()[0][0]


            cursor.execute(sql2,[int(tipo_de_atendimento_id)])
            preco = cursor.fetchall()[0][0]

            imposto_retido = round(preco * 0.05)

            comissao_da_clinica = 0
            valor_recebidos_por_medico = 0

            if eh_funcionario:
                comissao_da_clinica = round(preco * 0.30)
                valor_recebidos_por_medico = round(preco * 0.65)
            else:
                comissao_da_clinica = round(preco * 0.95)

            # datas de recebimento e data de repasse

            delta_dias = int(np.random.normal(loc=0, scale=8))

            data_de_repasse = None
            data_de_recebimento = horario_agendado +  datetime.timedelta(days=delta_dias)

            if data_de_recebimento > agora:
                data_de_recebimento = None

            elif not eh_funcionario:
                data_de_repasse = data_de_recebimento +  datetime.timedelta(weeks=1)

                if data_de_repasse > agora:
                    data_de_repasse = None

            cursor.execute(sql3,[int(plano_de_saude_id), int(tipo_de_atendimento_id)])
            desconto = cursor.fetchall()[0][0]

            desconto = preco * desconto

            inserirDados("Atendimento",['CRM', 'sala', 'estado', 'tipo_de_atendimento_id', 'plano_de_saude_id', 'tratamento_id', 'horario_agendado', 'horario_inicio_real','horario_fim_real', "valor","comissao_da_clinica","data_de_recebimento","valor_recebidos_por_medico","data_do_reparsse_ao_medico","imposto_retido","valor_pago_pelo_plano"],[[int(CRM), sala, estado, int(tipo_de_atendimento_id), int(plano_de_saude_id), int(tratamento_id), horario_agendado, horario_inicio_real,horario_fim_real, int(preco), comissao_da_clinica, data_de_recebimento, int(valor_recebidos_por_medico), data_de_repasse, int(imposto_retido), int(desconto)]])


# # fechar conexao

# In[33]:


cnx.close()


# In[ ]:




