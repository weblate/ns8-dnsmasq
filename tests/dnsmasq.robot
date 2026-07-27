*** Settings ***
Library    SSHLibrary
Library    DnsmasqTest.py

*** Variables ***
${INTERFACE}    eth0
${FIRST_ADDR}   192.168.0.1
${LAST_ADDR}    192.168.0.254
${SCENARIO}     install
${ADMIN_USER}    admin
${ADMIN_PASSWORD}    Nethesis,1234

*** Test Cases ***
Module installation
    [Tags]    create
    IF    r'${SCENARIO}' == 'update'
        Set Local Variable  ${iurl}  dnsmasq
    ELSE
        Set Local Variable  ${iurl}  ${IMAGE_URL}
    END
    ${output}  ${rc} =    Execute Command    add-module ${iurl} 1
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    &{output} =    Evaluate    ${output}
    Set Global Variable    ${MID}    ${output.module_id}

Take screenshots
    [Tags]    ui
    Import Library    Browser
    New Browser    chromium    headless=True
    New Context    ignoreHTTPSErrors=True
    Login to cluster-admin
    Go To    https://${NODE_ADDR}/cluster-admin/#/apps/${MID}
    Wait For Elements State    iframe >>> h2 >> text="Status"    visible    timeout=10s
    Sleep    5s
    Take Screenshot    filename=${OUTPUT DIR}/browser/screenshot/1._Status.png
    Go To    https://${NODE_ADDR}/cluster-admin/#/apps/${MID}?page=settings
    Wait For Elements State    iframe >>> h2 >> text="Settings"    visible    timeout=10s
    Sleep    5s
    Take Screenshot    filename=${OUTPUT DIR}/browser/screenshot/2._Settings.png
    Close Browser

Configure module
    &{output} =    Run task    module/${MID}/get-available-interfaces  {}
    Set Global Variable    ${INTERFACE}  ${output}[data][0][name]
    ${first}  ${last} =     GetDhcpRange  ${output}[data][0][network]
    Set Global Variable  ${FIRST_ADDR}  ${first}
    Set Global Variable  ${LAST_ADDR}  ${last}
    Run task    module/${MID}/configure-module  {"interface":"${INTERFACE}","dhcp-server":{"enabled":true,"start":"${FIRST_ADDR}","end":"${LAST_ADDR}","lease":4,"gateway":"${FIRST_ADDR}"},"dns-server":{"enabled":true,"primary-server":"8.8.4.4","secondary-server":"8.8.8.8"}}

Check module update
    [Tags]    create
    Log  Scenario ${SCENARIO} with ${IMAGE_URL}  console=${True}
    IF    r'${SCENARIO}' == 'update'
        ${out}  ${rc} =  Execute Command  api-cli run update-module --data '{"force":true,"module_url":"${IMAGE_URL}","instances":["${MID}"]}'  return_rc=${True}
        Should Be Equal As Integers  ${rc}  0  action update-module ${IMAGE_URL} failed
    END

Check DNSmasq config
    ${out}  ${err}  ${rc} =  Execute Command    while ! podman container exists ${MID} ; do sleep 0.3 ; done ; podman exec ${MID} dnsmasq --test
    ...    return_rc=True    return_stderr=True    timeout=5s
    Should Be Equal As Integers    ${rc}  0

Check DNS service
    ${out}  ${err}  ${rc} =  Execute Command    ss -lunp src 127.0.0.1:53
    ...    return_rc=True    return_stderr=True
    Should Contain    ${out}    dnsmasq

Check DHCP service
    ${out}  ${err}  ${rc} =  Execute Command    ss -lunp | grep ':67'
    ...    return_rc=True    return_stderr=True
    Should Contain    ${out}    dnsmasq


Check module removal
    [Tags]    remove
    ${out}  ${err}  ${rc} =  Execute Command    remove-module --no-preserve ${MID}
    ...    return_rc=True    return_stderr=True
    Should Be Equal As Integers    ${rc}  0


*** Keywords ***
Login to cluster-admin
    New Page    https://${NODE_ADDR}/cluster-admin/
    Fill Text    text="Username"    ${ADMIN_USER}
    Click    button >> text="Continue"
    Fill Text    text="Password"    ${ADMIN_PASSWORD}
    Click    button >> text="Log in"
    Wait For Elements State    css=#main-content    visible    timeout=10s

Run task
    [Arguments]    ${action}    ${input}    ${decode_json}=${TRUE}    ${rc_expected}=0
    ${stdout}    ${stderr}    ${rc} =     Execute Command    api-cli run ${action} --data '${input}'    return_stdout=True    return_stderr=True    return_rc=True
    Should Be Equal As Integers    ${rc_expected}    ${rc}    Run task ${action} failed!${\n}${stderr}
    IF    ${decode_json} and len($stdout) > 0
        ${response} =    Evaluate    json.loads('''${stdout}''')    modules=json
    ELSE
        ${response} =    Set Variable    ${stdout}
    END
    RETURN    ${response}
