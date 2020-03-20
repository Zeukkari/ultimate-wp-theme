*** Settings ***


*** Variables ***
${browser}          Chrome
${APP_URL}        	https://phz.fi/
${DELAY}         	0

# GUI variables
${Site_title}       Etusivu - PHZ.FI - Kestävän elinkaaren ohjelmistokehitys
${Main_Navbar}      id=main-navbar
${Logo_Navbar}                class=navbar__logo
${Services_Navbar}       class=navbar-item.Palvelut
${Values_Navbar}       class=navbar-item.Arvot
${Jobs_Navbar}       class=navbar-item.Työpaikat
${Contact_Navbar}       class=navbar-item.Yhteystiedot
${eSports_Navbar}       class=navbar-item.eSports
${Apprien_Navbar}       class=navbar-item.Apprien
${Games_Navbar}       class=navbar-item.PHZ.Game.Studios

${Cookies_Btn}      class=easy-cookies-policy-accept
${eSport_link}      xpath=/html/body/footer/div/div[1]/div[2]/ul/li[1]/a
${Prods_link}       xpath=/html/body/footer/div/div[1]/div[2]/ul/li[2]/a
${Jobs_link}        xpath=/html/body/footer/div/div[1]/div[2]/ul/li[3]/a
${PHZnet_link}      xpath=/html/body/footer/div/div[1]/div[2]/ul/li[4]/a
${Apprien_link}     xpath=/html/body/footer/div/div[1]/div[3]/ul/li/a
${Facebook_link}    xpath=/html/body/footer/div/div[1]/div[4]/ul/li[1]/a
${Instagram_link}   xpath=/html/body/footer/div/div[1]/div[4]/ul/li[2]/a
${Twitter_link}     xpath=/html/body/footer/div/div[1]/div[4]/ul/li[3]/a
${Help_link}        xpath=/html/body/footer/div/div[1]/div[5]/ul/li/a
${Smash_tab}         class=navbar-item.Smash
${Footer_section}    class=footer
${Privacy_link}                    xpath=/html/body/footer/div/div[3]/div[2]/a[1]
${Terms_link}       xpath=/html/body/footer/div/div[3]/div[2]/a[2]



*** Keywords ***

Start Application
    [Tags]    DEBUG
    Open Browser    ${APP_URL}    ${browser}
    Maximize Browser Window
    Set Selenium Speed  ${DELAY}
    Wait Until Page Contains Element    ${main_navbar}
    Close cookies disclaimer
    Title Should Be   ${Site_title}

Close Application
    Close All Browsers

Close cookies disclaimer
    Wait Until Element Is Visible   ${Cookies_Btn}
    Click Element       ${Cookies_Btn}
    Wait Until Element Is Not Visible        ${Cookies_Btn}

Go to footer
    Scroll Element Into View      ${Footer_section}

Open Navbar Links
    [Arguments]     ${TestDescription}     ${navbar_link}   ${target_url}  ${target_obj}
    Wait Until Element Is Visible      ${Main_Navbar}
    Click Element               ${navbar_link}
    Location Should Contain     ${target_url}
    Wait Until Page Contains    ${target_obj}
    Go Back
    Wait Until Page Contains Element     ${Main_Navbar}

Open footer links
    [Arguments]     ${TestDescription}     ${footer_link}     ${target_obj}
    Wait Until Element Is Visible      ${Footer_section}
    Click Element        ${footer_link}
    Wait Until Page Contains     ${target_obj}
    Go Back
    Wait Until Page Contains Element     ${Footer_section}


My Foo Bar Keyword
    [Documentation]    Does so and so
    [Arguments]        ${arg1}
    Do this
    Do that
    [Return]           Some value
