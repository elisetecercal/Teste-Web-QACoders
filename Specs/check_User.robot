*** Settings ***
Library    SeleniumLibrary
Variables   ../Pages/user_variables.py
Resource    ${EXECDIR}/Pages/user.robot
Suite Setup     Open Browser    about:blank    chrome
Suite Teardown  Close Browser

*** Variables ***
${url}=     https://automacao.qacoders-academy.com.br

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

    ${found} =    Set Variable    False
    Sleep   8s

    # Loop para iterar pelas páginas da lista de usuários
    WHILE    ${found} == False
        # Verificar se o novo usuário está na página atual
        ${found} =    Run Keyword And Return Status    Element Should Contain Text    xpath=/html/body/div[1]/div/div[2]/div[2]/div/ul    ${new_user_name}
        Sleep   8s

        # Se o usuário foi encontrado, saia do loop
        Run Keyword If    ${found} == True    Break Loop
        #Sleep   8s

        # Verificar se há um botão para avançar para a próxima página
        ${next_button_enabled} =  Run Keyword And Return Status  Element Should Be Enabled  ${bntAvancar1}
        #Sleep   8s

        # Se houver um botão para a próxima página, clique nele, senão falhe
        IF    ${next_button_enabled}
            Click Element  ${NavegaPelaLista.bntAvancar1}
        ELSE
            Fail    "Usuário não encontrado na lista após percorrer todas as páginas"
        END
        Sleep   8s
    END  # Fecha o loop

    # Assegure que o usuário foi encontrado
    Log    "Usuário ${new_user_name} encontrado na lista"
