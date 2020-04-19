describe('The user settings', function () {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/settings_spec.ts')
    cy.login()
    cy.visit('/settings/user')
  })
  it('has a valid form', function () {
    cy.document().toMatchImageSnapshot({
      name: `settings.${Cypress.env('viewtype')}`,
      blackout: [
        '[name=language]'
      ]
    })
  })
  it('should allow changing the password', function () {
    cy.get('[name=current_password]').type(this.testdata.users[0].password)
    cy.get('[name=password]').type(this.testdata.settings.changedPassword)
    cy.get('[name=password2]').type(this.testdata.settings.changedPassword)
    cy.get('.elgg-form-usersettings-save .elgg-button-submit').click()
    cy.logout()
    cy.login(this.testdata.users[0].username, this.testdata.settings.changedPassword)
  })
})
