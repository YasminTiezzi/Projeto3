*** Settings ***

Library        SeleniumLibrary

*** Variables ***

${NAVEGADOR}                        Chrome
${LINK}                             https://std.gestorjuridico.com.br/Paginas/Principal/_FSet_Abertura.asp
${LOGIN}                            id:txtcd_Logon
${SENHA}                            id:txtcd_Pwd
${ELEMENT_KEYBOARD}                 id:keyboardInputMaster
${BUTTON_LOGIN}                     id:btOK
${BUTTON_UNIDADE}                   id:btOk
${SELECIONAR_MODO}                  xpath://*[@id="cmbUnidade"]/option[3]
${SEL_JURIDICO}                     css:a[rel="PJ"]
${MENU_FRAME}                       id:FraMenu
${NEXT}                             css:frame[src]
${PAG2}                             xpath://div[1]/a[@id="pagNext"][contains(text(), '2')][1]

*** Tasks ***

Tarefa 1:
    [Documentation]        
    ENTRAR NO SITE
    REALIZAR A BUSCA DO CASO
    #ACESSAR A PLANILHA

*** Keywords ***

ENTRAR NO SITE
    [Documentation]    
    Open Browser      ${LINK}     ${NAVEGADOR}
    Maximize Browser Window
    Input Text        ${LOGIN}     std.sbk
    Wait Until Element Is Enabled    ${SENHA}
    Input Text        ${SENHA}     1234asdf
    Wait Until Element Is Visible        ${ELEMENT_KEYBOARD}
    Click Button      ${BUTTON_LOGIN}

REALIZAR A BUSCA DO CASO
    [Documentation]    
    Wait Until Element Is Visible    ${SELECIONAR_MODO}
    Click Element                    ${SELECIONAR_MODO}
    Wait Until Element Is Enabled    ${BUTTON_UNIDADE}
    Click Button                     ${BUTTON_UNIDADE}
    Select Frame                     ${MENU_FRAME}
    Click Element                    ${SEL_JURIDICO}
    Go To    https://std.gestorjuridico.com.br/popup/pop.asp?url=documento_causa_list_pop.asp&amp;cd_Causa=CIV0000556
    Run Keyword And Return Status    handle Alert    timeout=10s
    Select Frame                     ${NEXT}
    Click Element                    ${PAG2}
    Run Keyword And Return Status    handle Alert    timeout=10s
    Execute Javascript      Baixar('DOC','-5','xlsx')
    