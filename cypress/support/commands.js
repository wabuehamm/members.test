Cypress.Commands.add('login', (username, password) => {
    if (!username) {
        username = Cypress.env('username')
    }

    if (!password) {
        password = Cypress.env('password')
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

