*** Settings ***

Library      SeleniumLibrary

*** Variables ***

${url}                 https://automacao.qacoders.dev.br/login


&{Login}
...     email=//*[@id="email"]
...     senha=//*[@id="password"]
...     btnEntrar=//*[@id="login"]

&{CadastrosUsuario}
...     bntCadastros=//*[@id="Cadastros"]
...     bntUsuarios=//*[@id="Usuários"]
...     bntNovoCadastro=//*[@id="Novo Cadastro"]
...     NomeCompletoUsuario=//*[@id="fullName"]
...     EmailUsuario=//*[@id="mail"]
...     PerfilDeAcessoUsuario=//*[@id="accessProfile"]
...     CPFUsuario=//*[@id="cpf"]
...     SenhaUsuario=//*[@id="password"]
...     ConfirmeSenhaUsuario=//*[@id="confirmPassword"]
...     bntSalvarNovoUsuario=//*[@id="save"]

&{PreencheFormularioLogin}
...     email=sysadmin@qacoders.com
...     senha=1234@Test

&{NavegaPelaLista}
...     bntAvancar1=//button[contains(@class, 'css-kab9pu') and @aria-label='Next page']


&{MessagemErroCpf}
...     msgCpfDuplicado=xpath=//div[contains(@class, 'MuiAlert-message') and contains(@class, 'css-1xsto0d')]

&{MensagemErroNomeCompleto}
...     msgNomeCompleto=xpath=//div[contains(@class, 'MuiAlert-message') and contains(@class, 'css-1xsto0d')]
