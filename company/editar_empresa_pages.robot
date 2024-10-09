*** Settings ***

Library      SeleniumLibrary

***Variables***

&{Login}
...     email=//*[@id="email"]
...     senha=//*[@id="password"]
...     btnEntrar=//*[@id="login"]

&{CadastrosEmpresa}
...     bntCadastros=//*[@id="Cadastros"]
...     bntEmpresa=//*[@id="Empresa"]
...     bntNovoCadastro=//*[@id="Novo Cadastro"]
...     razaoSocial=//*[@id="companyName"]
...     nomeFantasia=//*[@id="fantasyName"]
...     emailEmpresa=//*[@id="companyMail"]
...     cnpj=//*[@id="matriz"]
...     telefone=//*[@id="telephone"]
...     descricaoDoServico=//*[@id="serviceDescription"]
...     nomeDoResponsavel=//*[@id="fullName"]
...     cep=//*[@id="zipCode"]
...     pais=//*[@id="country"]
...     cidade=//*[@id="city"]
...     estado=//*[@id="state"]
...     bairro=//*[@id="district"]
...     rua=//*[@id="street"]
...     numero=//*[@id="number"]
...     complemento=//*[@id="complement"]
...     bntSalvarNovo=//*[@id="save"]

&{PreencheFormularioLogin}
...     email=sysadmin@qacoders.com
...     senha=1234@Test

&{EditarEmpresa}
...     bntEditar=//*[@id="edit"]
...     bntSalvarNovoEditar=//*[@id="save"]
...     bntSalvarNovoCancelar=//*[@id="cancel"]

