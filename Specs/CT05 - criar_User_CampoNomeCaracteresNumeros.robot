*** Settings ***
Library     SeleniumLibrary
Library     Collections
Variables   ../Pages/user_variables.py  # Importando seu arquivo de variáveis Python
Resource    ${EXECDIR}/Pages/user.robot
Suite Setup     Open Browser    about:blank    chrome
Suite Teardown  Close Browser



*** Test Cases ***
Realizar Login e Cadastrar novo Usuario com apenas Nome
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
    Input Text     ${CadastrosUsuario.NomeCompletoUsuario}  ${PreencheFormularioUsuarioString['NomeCompletoUsuarioString']}
    Input Text     ${CadastrosUsuario.EmailUsuario}  ${PreencheFormularioUsuario['EmailUsuario']}
    Input Text     ${CadastrosUsuario.PerfilDeAcessoUsuario}  ${PreencheFormularioUsuario['PerfilDeAcessoUsuario']}
    Input Text     ${CadastrosUsuario.CPFUsuario}  ${PreencheFormularioUsuario['CPFUsuario']}
    Input Text     ${CadastrosUsuario.SenhaUsuario}  ${PreencheFormularioUsuario['SenhaUsuario']}
    Input Text     ${CadastrosUsuario.ConfirmeSenhaUsuario}  ${PreencheFormularioUsuario['ConfirmeSenhaUsuario']}

    # Captura de Tela antes de Submeter
    Capture Page Screenshot  name=Antes_de_Salvar.png

    # Passo 4: Tenta salvar o novo usuário
    Click Element  ${CadastrosUsuario.bntSalvarNovoUsuario}
    Sleep   3s

    Wait Until Element Is Visible   ${MensagemErroNomeCompleto.msgNomeCompleto}
    # Verica se a mensagem de erro é exibida
    Element Should Contain    ${MensagemErroNomeCompleto.msgNomeCompleto}   O campo nome completo não deve conter números

    # Captura a messagem de erro
    Capture Page Screenshot    name=Depois_de_Verificar_Mensagem_de_Erro_Nome.png

    # Log o sucesso do teste
    Log To Console    "O sistema corretamente impediu o cadastro de um Nome Completo."
