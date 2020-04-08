describe('The manual', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/manual_spec.ts')
    cy.login()
    cy.visit('/pages/view/53543/handbuch-zum-mitgliederbereich')
  })

  it('is reachable', function () {
    cy.contains(this.identifiers.manual.title)

    cy.document().toMatchImageSnapshot({
      name: 'manual',
      blackout: [
        '.elgg-listing-full-header',
        '.elgg-listing-full-responses'
      ]
    })
  })
})
