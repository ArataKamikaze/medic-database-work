const faker = require('faker')
const Leite = require('leite')

faker.locale = "pt_BR";
const data = []
const leite = new Leite()

async function generateData() {

    let card = faker.helpers.createCard()
    let nome = leite.pessoa.nome()
    let emailLimpo = await removerAcentos(nome)
    let emailp1 = emailLimpo.toLowerCase()
    let email = `${emailp1}@gmail.com`
    let cpf = leite.pessoa.cpf({ formatado: true })
    let cep = leite.localizacao.cep({ formatado: true })
    let bairro = leite.localizacao.bairro()
    let cidade = leite.localizacao.cidade()
    let estado = leite.localizacao.estado()
    let complemento = leite.localizacao.complemento()
    let nascimento = leite.pessoa.nascimento({ string: true })
    let logradouro = leite.localizacao.logradouro()
    const randomCivil = ['Solteiro(a)', 'Casado(a)', 'Viúvo(a)', 'Divorciado', 'Separado']
    let estadoCivil = faker.random.arrayElement(randomCivil)

    const random = new Object()

    random.nome = nome
    random.email = email
    random.cpf = cpf
    random.estado_civil = estadoCivil
    random.sexo = Math.floor(Math.random() * Math.floor(2))
    random.data_de_nascimento = nascimento
    random.numero_do_telefone = card.phone
    random.cep = cep
    random.estado = estado
    random.cidade = cidade
    random.bairro = bairro
    random.logradouro = logradouro
    random.complemento = complemento
    random.numero = Math.floor(Math.random() * 100)

    return random
}

async function removerAcentos(str) {
    return str.normalize("NFD").replace(/[^a-zA-Zs]/g, "")
}

async function generate() {
    for (let i = 0; i < 500; i++) {

        let potato = await generateData()
        data.push(potato)
    }

    return data
}

async function showData() {
    let finalData = await generate()

    console.log(JSON.stringify(finalData))

}

showData()