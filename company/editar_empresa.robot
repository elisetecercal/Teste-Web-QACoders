*** Settings ***

Library     SeleniumLibrary
Variables   ../company/company_variables.py
Resource    ${EXECDIR}/company/editar_empresa_pages.robot
Suite Setup     Open Browser    about:blank    chrome
Suite Teardown    Close Browser

*** Variables ***
${url}=     https://automacao.qacoders-academy.com.br

*** Test Cases ***
Realizar Login e Cadastrar no Empresa

    Go To  ${url}
    Wait Until Element Is Visible    //*[@id="email"]    20s
    Input Text  ${Login.email}    ${PreencheFormularioLogin.email}
    Wait Until Element Is Visible    //*[@id="password"]    20s
    Input Text  ${Login.senha}    ${PreencheFormularioLogin.senha}
    Click Element   ${Login.btnEntrar}
    Sleep   3s
    # Tentar realizar cadastro de Nova Empresa
    Click Element   ${CadastrosEmpresa.bntCadastros}
    Click Element   ${CadastrosEmpresa.bntEmpresa}
    Capture Page Screenshot
    Wait Until Element Is Visible    xpath=//*[@id="Novo Cadastro"]    15s
    Click Element   ${CadastrosEmpresa.bntNovoCadastro}
    Input Text      ${CadastrosEmpresa.razaoSocial}    ${PreencheFormularioEmpresa['razaoSocial']}
    Input Text      ${CadastrosEmpresa.nomeFantasia}   ${PreencheFormularioEmpresa['nomeFantasia']}
    Input Text      ${CadastrosEmpresa.emailEmpresa}    ${PreencheFormularioEmpresa['emailEmpresa']}
    Input Text      ${CadastrosEmpresa.cnpj}    ${PreencheFormularioEmpresa['cnpj']}
    Capture Page Screenshot
    Input Text      ${CadastrosEmpresa.telefone}    ${PreencheFormularioEmpresa['telefone']}
    Input Text      ${CadastrosEmpresa.descricaoDoServico}  ${PreencheFormularioEmpresa['descricaoDoServico']}
    Input Text      ${CadastrosEmpresa.nomeDoResponsavel}   ${PreencheFormularioEmpresa['nomeDoResponsavel']}
    Input Text      ${CadastrosEmpresa.cep}    ${PreencheFormularioEmpresa['cep']}
    Input Text      ${CadastrosEmpresa.pais}    ${PreencheFormularioEmpresa['pais']}
    Input Text      ${CadastrosEmpresa.cidade}     ${PreencheFormularioEmpresa['cidade']}
    Input Text      ${CadastrosEmpresa.estado}     ${PreencheFormularioEmpresa['estado']}
    Input Text      ${CadastrosEmpresa.bairro}     ${PreencheFormularioEmpresa['bairro']}
    Input Text      ${CadastrosEmpresa.rua}    ${PreencheFormularioEmpresa['rua']}
    Input Text      ${CadastrosEmpresa.numero}     ${PreencheFormularioEmpresa['numero']}
    Input Text      ${CadastrosEmpresa.complemento}    ${PreencheFormularioEmpresa['complemento']}
    Capture Page Screenshot
    Click Element   ${CadastrosEmpresa.bntSalvarNovo}
    Sleep   3s
    Capture Page Screenshot
    Sleep   3s

    # verifica se o a mensagem de erro esta na pagina
    ${error_present}=  Run Keyword And Return Status   Element Should Be Visible   xpath=//*[@data-testid="ErrorOutlineIcon"]

    #Falha o teste se a mensagem de erro for exibida
    Run Keyword If    ${error_present}    Fail    "Cadastro de Empresa falhou devido a erro exibido na tela."

    # Log de sucesso e captura uma screenshot se não houver erro
    Log    "Cadastro de Empresa realizado com sucesso."
    Capture Page Screenshot    name=Cadastro_De_Empresa_Sucesso.png
