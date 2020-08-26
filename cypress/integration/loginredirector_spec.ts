describe('The login redirector plugin', function () {
  it('should show the board on first login', function () {
    cy.visit('/')
    cy.get('input[name=username]').type(this.testdata.users[ 0 ].username)
    cy.get('input[name=password]').type(this.testdata.users[ 0 ].password)
    cy.get('.elgg-form-login').submit()
    cy.get(this.identifiers.loginredirector.default)
  })

  const runTest = function (testdata, key, value) {
    cy.login()
    cy.visit(`/settings/plugins/${testdata.users[ 0 ].username}/login_redirector`)
    key = key.replace('%baseUrl%', Cypress.config('baseUrl'))
    cy.get('[name="params[redirectpage]"]').select(key)
    cy.get('.elgg-form-plugins-usersettings-save').submit()
    cy.logout()
    cy.visit('/')
    cy.get('input[name=username]').type(testdata.users[ 0 ].username)
    cy.get('input[name=password]').type(testdata.users[ 0 ].password)
    cy.get('.elgg-form-login').submit()
    cy.get('.elgg-spinner').should('not.be.visible')
    cy.get('.elgg-heading-main').contains(value)
  }

  it('should correctly redirect to the selected settings', function () {
      for (const key in this.identifiers.loginredirector.redirects) {
        if (this.identifiers.loginredirector.redirects.hasOwnProperty(key)) {
          const value = this.identifiers.loginredirector.redirects[ key ]
          runTest(this.testdata, key, value)
        }
      }
    }
  )

})
