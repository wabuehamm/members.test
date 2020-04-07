Cypress.Commands.add('login', function (username, password) {
    if (!username) {
        username = this.testuser[0].username
    }

    if (!password) {
        password = this.testuser[0].password
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

Cypress.Commands.add('prepare', function () {
    expect(Cypress.env('admin_username'), 'No CYPRESSS_admin_username environment variable found').to.not.be.undefined
    expect(Cypress.env('admin_password'), 'No CYPRESSS_admin_password environment variable found').to.not.be.undefined

    cy.login(Cypress.env('admin_username'), Cypress.env('admin_password'))

    for (const testUser of this.testuser) {
        cy.request({
            method: 'GET',
            url: `/profile/${testUser.username}`,
            failOnStatusCode: false
        })
            .then(
                resp => {
                    if (resp.status !== 404) {
                        const matches = resp.body.match('data-page-owner-guid="([^"]+)')
                        if (matches) {
                            const guid = matches[1]
                            cy.request({
                                url: `/action/admin/user/delete?guid=${guid}`
                            })
                        }
                    }
                }
            )
            .then(
                () => {
                    cy.request({
                        method: 'POST',
                        url: '/action/useradd',
                        form: true,
                        body: testUser
                    })
                        .then(
                            (resp) => {
                                expect(resp.status).to.eq(200)
                            }
                        )
                }
            )
    }
})

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
