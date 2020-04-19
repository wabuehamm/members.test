describe('The activity stream', function () {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/activitystream_spec.ts')
    cy.login()
    cy.visit('/activity')
  })

  it('is reachable', function() {
    cy.contains(this.identifiers.activityStream.title)
    cy.document().toMatchImageSnapshot({
      name: `activityStream.${Cypress.env('viewtype')}`,
      blackout: [
        '.elgg-list'
      ]
    })
  })
  it('contains enough entries', function () {
    cy.get('.elgg-item').should('have.length.of.at.least', this.counts.activityStream.minEntries)
  })
  it('has pagination', function () {
    cy.get('.elgg-pagination li').should('have.length.of.at.least', this.counts.activityStream.minPages)
  })
})
