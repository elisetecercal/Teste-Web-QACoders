*** Settings ***
Library     SeleniumLibrary
Library     Collections
Variables   ../Pages/user_variables.py  # Importando seu arquivo de variáveis Python
Resource    ${EXECDIR}/Pages/user.robot
Suite Setup     Open Browser    about:blank    chrome
Suite Teardown  Close Browser



*** Test Cases ***
Realizar Login e Cadastrar novo Usuario Com Nome Vazio
    # Passo 1: Acesse o site e realize o login
    Go To  ${url}
    Wait Until Element Is Visible    ${Login.email}    10s
    Input Text  ${Login.email}    ${PreencheFormularioLogin.email}
    Wait Until Element Is Visible    ${Login.senha}    10s
    Input Text  ${Login.senha}    ${PreencheFormularioLogin.senha}
    Click Element   ${Login.btnEntrar}
    Sleep   3s

    # Passo 2: Navegue até a página de cadastro de usuários
    Click Element   ${CadastrosUsuario.bntCadastros}
    Sleep   3s
    Click Element   ${CadastrosUsuario.bntUsuarios}
    Wait Until Element Is Visible    ${CadastrosUsuario.bntNovoCadastro}    10s
    Click Element   ${CadastrosUsuario.bntNovoCadastro}
    Wait Until Element Is Visible    ${CadastrosUsuario.NomeCompletoUsuario}    10s

    # Passo 3: Preenche o formulário de novo usuário, com Nome Completo vazio
    Input Text     ${CadastrosUsuario.NomeCompletoUsuario}  ${PreencheFormularioUsuario['NomeCompletoUsuario']}
    Input Text     ${CadastrosUsuario.EmailUsuario}  ${ValorVazio}
    Input Text     ${CadastrosUsuario.PerfilDeAcessoUsuario}  ${PreencheFormularioUsuario['PerfilDeAcessoUsuario']}
    Input Text     ${CadastrosUsuario.CPFUsuario}  ${PreencheFormularioUsuario['CPFUsuario']}
    Input Text     ${CadastrosUsuario.SenhaUsuario}  ${PreencheFormularioUsuario['SenhaUsuario']}
    Input Text     ${CadastrosUsuario.ConfirmeSenhaUsuario}  ${PreencheFormularioUsuario['ConfirmeSenhaUsuario']}

    # Captura de Tela antes de Submeter
    Capture Page Screenshot  name=Antes_de_Salvar.png

    # Passo 4: Tenta salvar o novo usuário
    Click Element  ${CadastrosUsuario.bntSalvarNovoUsuario}
    Sleep   3s

    # Captura de Tela após tentar Submeter o Formulário
    Capture Page Screenshot  name=Depois_de_Salvar.png

    # Passo 5: Verifica se a mensagem de erro é exibida /html/body/div[1]/div/div[2]/div/form/div[3]/p
    Element Should Be Visible    xpath=//p[contains(@class, 'css-bbipig') and contains(text(), 'O campo email é obrigatório')]

    # Verifica se o texto da mensagem de erro é o esperado
    Element Text Should Be    xpath=//p[contains(@class, 'css-bbipig') and contains(text(), 'O campo email é obrigatório')]    O campo email é obrigatório
