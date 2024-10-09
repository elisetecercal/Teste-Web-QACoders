*** Settings ***

Library     SeleniumLibrary
Variables   ../company/company_variables.py
Resource    ${EXECDIR}/company/editar_empresa_pages.robot
Suite Setup     Open Browser    about:blank    chrome
Suite Teardown    Close Browser

*** Variables ***
${url}=     https://automacao.qacoders-academy.com.br

*** Test Cases ***
Realizar Login e Editar campo Nome da Empresa

    Go To  ${url}
    Wait Until Element Is Visible    //*[@id="email"]    20s
    Input Text  ${Login.email}    ${PreencheFormularioLogin.email}
    Wait Until Element Is Visible    //*[@id="password"]    20s
    Input Text  ${Login.senha}    ${PreencheFormularioLogin.senha}
    Click Element   ${Login.btnEntrar}
    Sleep   3s

    Click Element   ${CadastrosEmpresa.bntCadastros}
    Click Element   ${CadastrosEmpresa.bntEmpresa}
    Capture Page Screenshot
    Wait Until Element Is Visible   xpath=/html/body/div[1]/div/div[2]/div[2]/div/ul/li[1]/div[4]/button
    Sleep  3s
    Capture Page Screenshot
    Click Element   ${EditarEmpresa.bntEditar}

    Sleep  3s
    Input Text      ${CadastrosEmpresa.razaoSocial}    ${PreencheFormularioEmpresa['razaoSocial']}
    Log To Console
    Capture Page Screenshot
    Sleep  3s
    Click Element   ${EditarEmpresa.bntSalvarNovoEditar}

    Capture Page Screenshot





