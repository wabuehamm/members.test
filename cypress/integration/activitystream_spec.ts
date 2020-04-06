beforeEach(() => {
  cy.login()
  cy.visit('/activity')
})

describe('The activity stream', function () {
  it('is reachable', function() {
    cy.contains(this.identifiers.activityStream.title)
    cy.compareSnapshot('activityStream')
  })
  it('contains enough entries', function () {
    cy.get('.elgg-item').should('have.length.of.at.least', this.counts.activityStream.minEntries)
  })
  it('has pagination', function () {
    cy.get('.elgg-pagination li').should('have.length.of.at.least', this.counts.activityStream.minPages)
  })
})
