describe('When logging in into the membership area', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/login_spec.ts')
  })

  it('the login form is reachable', () => {
    cy.visit('/')
    cy.get('input[name=username]').should('be.visible')
    cy.get('input[name=password]').should('be.visible')
    cy.document().toMatchImageSnapshot({
      name: 'login'
    })
  })
  it('a login is possible', () => {
    cy.login()
  })
  it('a logout is possible', () => {
    cy.login()
    cy.visit('/')
    cy.get('[data-menu-item=account] ul').invoke('show').should('be.visible')
    cy.get('[data-menu-item=logout').click()

    cy.get('[data-menu-item=account]').should('not.be.visible')
  })
})
