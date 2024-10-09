*** Settings ***
Library     SeleniumLibrary
Library     Collections
Variables   ../Pages/user_variables.py
Resource    ${EXECDIR}/Pages/user.robot
Suite Setup     Open Browser    about:blank    chrome
Suite Teardown  Close Browser

*** Variables ***
${url}=     https://automacao.qacoders.dev.br/login

*** Test Cases ***
Realizar Login e Cadastrar novo Usuario
    # Acesse o site
    Go To  ${url}
    Wait Until Element Is Visible    ${Login.email}    20s
    Input Text  ${Login.email}    ${PreencheFormularioLogin.email}
    Wait Until Element Is Visible    ${Login.senha}    15s
    Input Text  ${Login.senha}    ${PreencheFormularioLogin.senha}
    Click Element   ${Login.btnEntrar}
    Sleep   3s

    # Navegue até a página de cadastro de usuários
    Click Element   ${CadastrosUsuario.bntCadastros}
    Sleep   3s
    Click Element   ${CadastrosUsuario.bntUsuarios}
    Wait Until Element Is Visible    ${CadastrosUsuario.bntNovoCadastro}    10s
    Click Element   ${CadastrosUsuario.bntNovoCadastro}
    Wait Until Element Is Visible    ${CadastrosUsuario.NomeCompletoUsuario}    10s

    # Preenche o formulário de novo usuário
    Input Text     ${CadastrosUsuario.NomeCompletoUsuario}  ${PreencheFormularioUsuario['NomeCompletoUsuario']}
    Input Text     ${CadastrosUsuario.EmailUsuario}  ${PreencheFormularioUsuario['EmailUsuario']}
    Input Text     ${CadastrosUsuario.PerfilDeAcessoUsuario}  ${PreencheFormularioUsuario['PerfilDeAcessoUsuario']}
    Input Text     ${CadastrosUsuario.CPFUsuario}  ${PreencheFormularioUsuario['CPFUsuario']}
    Input Text     ${CadastrosUsuario.SenhaUsuario}  ${PreencheFormularioUsuario['SenhaUsuario']}
    Input Text     ${CadastrosUsuario.ConfirmeSenhaUsuario}  ${PreencheFormularioUsuario['ConfirmeSenhaUsuario']}
    Capture Page Screenshot
    Click Element  ${CadastrosUsuario.bntSalvarNovoUsuario}
    Sleep   3s
      # Armazena o nome gerado na variável ${new_user_name} e o CPF gerado na variável global ${CPFUnico}
    ${new_user_name} =    Set Variable    ${PreencheFormularioUsuario['NomeCompletoUsuario']}
    ${CPF_Unico} =    Set Variable    ${PreencheFormularioUsuario['CPFUsuario']}
    Log To Console    "Nome do usuário criado: ${new_user_name}"
    Log To Console    "CPF gerado: ${CPF_Unico}"
    # Capture and print the response(s)
    ${responses}=    Execute Javascript    return window._responses;
    Log    ${responses}
    Capture Page Screenshot

Recadastro Com CPF Duplicado
    Wait Until Element Is Visible    ${CadastrosUsuario.bntNovoCadastro}    10s
    Click Element   ${CadastrosUsuario.bntNovoCadastro}
    Wait Until Element Is Visible    ${CadastrosUsuario.NomeCompletoUsuario}    10s
    Sleep   3s
    # Tentativa de recadastrar o usuário com o mesmo CPF
    Input Text     ${CadastrosUsuario.NomeCompletoUsuario}  ${PreencheFormularioUsuario['NomeCompletoUsuario']}
    Input Text     ${CadastrosUsuario.EmailUsuario}  ${PreencheFormularioUsuario['EmailUsuario']}
    Input Text     ${CadastrosUsuario.PerfilDeAcessoUsuario}  ${PreencheFormularioUsuario['PerfilDeAcessoUsuario']}
    Capture Page Screenshot
    Input Text     ${CadastrosUsuario.CPFUsuario}    ${CPF_Unico}  # Mesmo CPF usado anteriormente
    Input Text     ${CadastrosUsuario.SenhaUsuario}    ${PreencheFormularioUsuario['SenhaUsuario']}
    Sleep   3s
    Input Text     ${CadastrosUsuario.ConfirmeSenhaUsuario}  ${PreencheFormularioUsuario['ConfirmeSenhaUsuario']}

    # Captura a screenshot antes de salvar
    Capture Page Screenshot    name=Antes_de_Tentar_Salvar_Recadastro_CPF.png

    # tenta salvar o usuário com Nome Completo e CPF repetidos
    Click Element  ${CadastrosUsuario.bntSalvarNovoUsuario}
    Sleep   3s

    # Verica se a mensagem de erro é exibida
    Element Should Contain    ${MessagemErroCpf.msgCpfDuplicado}   O cpf informado já existe em nossa base de dados.

    # Captura a messagem de erro
    Capture Page Screenshot    name=Depois_de_Verificar_Mensagem_de_Erro_CPF.png

    # Log o sucesso do teste
    Log To Console    "O sistema corretamente impediu o cadastro de um CPF duplicado."
