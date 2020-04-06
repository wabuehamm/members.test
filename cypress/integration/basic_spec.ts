beforeEach(() => {
  cy.login()
})

describe('The membership area', () => {
  it('displays the required items', () => {
    cy.visit('/')

    cy.get('div.elgg-nav-logo').should('be.visible')
    cy.get('div.elgg-nav-search').should('be.visible')
    cy.get('[data-menu-item=account]').should('be.visible')
    cy.compareSnapshot('basic')
  })

  it('contains all required menu items in the account menu', () => {
    cy.visit('/')

    cy.get('[data-menu-item=account] ul').invoke('show').should('be.visible')
    cy.get('[data-menu-item=profile').should('be.visible')
    cy.get('[data-menu-item=usersettings').should('be.visible')
    cy.get('[data-menu-item=friends').should('be.visible')
    cy.get('[data-menu-item=logout').should('be.visible')
  })
})
