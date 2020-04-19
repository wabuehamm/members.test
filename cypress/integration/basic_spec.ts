describe('The membership area', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/basic_spec.ts')
    cy.login()
    cy.visit('/')
  })

  it('displays the required items', () => {
    cy.get('div.elgg-nav-logo').should('be.visible')
    cy.get('div.elgg-nav-search').should('be.visible')
    cy.get('[data-menu-item=account]').should('be.visible')

    cy.document().toMatchImageSnapshot({
      name: `basic.${Cypress.env('viewtype')}`,
      blackout: [
        '.elgg-page-body'
      ]
    })
  })

  it('contains all required menu items in the account menu', () => {
    cy.get('[data-menu-item=account] ul').invoke('show').should('be.visible')
    cy.get('[data-menu-item=profile').should('be.visible')
    cy.get('[data-menu-item=usersettings').should('be.visible')
    cy.get('[data-menu-item=friends').should('be.visible')
    cy.get('[data-menu-item=logout').should('be.visible')
  })
})
