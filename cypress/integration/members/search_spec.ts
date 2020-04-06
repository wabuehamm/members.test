beforeEach(() => {
  cy.login()
  cy.visit('/members/alpha')
})

describe('The search on the list of members', function () {
  it('should exist', () => {
    cy.get('[name=member_query]').should('be.visible')
  })
  it('should return correct results', function () {
    cy.get('[name=member_query]').type(this.identifiers.members.searchKeyword + '{enter}')
    cy.get('.elgg-item').should('have.length.of.at.least', this.counts.members.searchResults)
    cy.document().toMatchImageSnapshot({ name: 'members_search' })
  })
})
