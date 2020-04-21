/**
 * Login to the member area
 * @param username Username to use (defaults to the first testuser username)
 * @param password Password to use (defaults to the first testuser password)
 */
Cypress.Commands.add('login', function (username, password) {
    if (!username) {
        username = this.testdata.users[0].username
    }

    if (!password) {
        password = this.testdata.users[0].password
    }

    cy.request({
        method: 'POST',
        url: '/action/login',
        form: true,
        body: {
            username: username,
            password: password
        }
    })
        .then(
            resp => {
                expect(resp.status).to.eq(200)
                expect(cy.getCookie('Elgg')).to.exist
            }
        )
})

/**
 * Prepare test environment. Login as admin, recreate test users
 */
Cypress.Commands.add('prepare', function () {
    cy.log('Checking admin credentials')
    if (!Cypress.env('admin_username')) {
        expect(false, 'No CYPRESSS_admin_username environment variable found').to.be.true
    }

    if (!Cypress.env('admin_password')) {
        expect(false, 'No CYPRESSS_admin_password environment variable found').to.be.true
    }

    cy.log('Logging in as admin user')
    cy.login(Cypress.env('admin_username'), Cypress.env('admin_password'))

    for (const testUser of this.testdata.users) {
        cy.log(`(Re-)creating user ${testUser.username}`)
        cy.request({
            url: `/services/api/rest/json/?method=auth.gettoken&username=${Cypress.env('admin_username')}&password=${Cypress.env(
                'admin_password')}`,
            method: 'POST'
        })
            .then(
                resp => {
                    expect(resp.body.status).to.eq(0)
                    const token = resp.body.result
                    this.token = token
                    const user = encodeURIComponent(JSON.stringify(testUser))
                    cy.request({
                        method: 'POST',
                        url: `/services/api/rest/json/?method=wabue.users.add&auth_token=${token}&user=${user}`
                    })
                        .then(
                            (resp) => {
                                expect(resp.status).to.eq(200)
                            }
                        )
                }
            )
    }

    cy.clearCookies()
})

/**
 * A temporary cypress fix for visual testing in the complete testsuite as long as
 * https://github.com/cypress-io/cypress/issues/3090 is around
 *
 * @param filename path to filename of spec
 */
Cypress.Commands.add('fixCypressSpec', (filename) => {
    const path = require('path')
    const relative = filename.substr(1) // removes leading "/"
    const projectRoot = Cypress.config('projectRoot')
    const absolute = path.join(projectRoot, relative)
    Cypress.spec = {
        absolute,
        name: path.basename(filename),
        relative
    }
})

/**
 * Workaround to type into CKEditor instance using Cypress. Courtesy of
 * https://medium.com/@nickdenardis/getting-cypress-js-to-interact-with-ckeditor-f46eec01132f
 */
Cypress.Commands.add('typeCkEditor', (content, instanceID = null) => {
    cy.get('iframe')
    cy.window()
        .then(win => {
            let editorInstance
            if (instanceID) {
                editorInstance = win.CKEDITOR.instances[instanceID]
            } else {
                editorInstance = win.CKEDITOR.instances[Object.keys(win.CKEDITOR.instances)[0]]
            }

            editorInstance.setData(content)
            editorInstance.updateElement()
        })
})

/**
 * Attach a file to an input
 *
 * @param input The input element
 * @param fileName The name of the file to upload in the fixtures
 * @param fileType The type of the file to upload
 */
Cypress.Commands.add(
    'attachFile',
    {
        prevSubject: 'element',
    },
    (input, fileName, fileType) => {
        cy.fixture(fileName)
            .then(content => {
                if (fileType.startsWith('text')) {
                    return content
                } else {
                    return Cypress.Blob.base64StringToBlob(content, fileType)
                }
            })
            .then(blob => {
                const testFile = new File([blob], fileName)
                const dataTransfer = new DataTransfer()

                dataTransfer.items.add(testFile)
                input[0].files = dataTransfer.files
                return input
            })
    }
)

Cypress.Commands.add(
    'clearNotifications',
    (token) => {
        cy.log('Triggering notifications')
        cy.request({
            url: `/services/api/rest/json/?method=filetransport.notifications.send&auth_token=${token}`,
            method: 'POST'
        })
            .then(
                resp => {
                    expect(resp.body.status).to.eq(0)
                    cy.log('Flushing notifications')
                    cy.request({
                        url: `/services/api/rest/json/?method=filetransport.notifications.flush&auth_token=${token}`,
                        method: 'POST'
                    })
                        .then(resp => {
                            expect(resp.body.status).to.eq(0)
                        })
                }
            )

    }
)

/**
 * Quickly stub a test as to be done
 */
Cypress.Commands.add(
    'todo',
    () => {
        expect(false, 'Test has yet to be written').to.be.true
    }
)

/**
 * Logout of the members area
 */
Cypress.Commands.add(
    'logout',
    () => {
        if (Cypress.env('viewtype') == 'mobile') {
            cy.get('.elgg-nav-button').should('be.visible').click()
        } else {
            cy.get('[data-menu-item=account] ul').invoke('show').should('be.visible')
        }
        cy.get('[data-menu-item=logout').click()
        cy.clearCookies()
        cy.get('[data-menu-item=account]').should('not.be.visible')
    }
)
