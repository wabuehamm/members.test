describe('The board feature', () => {
  beforeEach(function () {
    cy.fixCypressSpec('/cypress/integration/board_spec.ts')
    cy.login()
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
  })

  it('is reachable', function () {
    cy.contains(this.identifiers.board.title)

    cy.document().toMatchImageSnapshot({
      name: 'board',
      blackout: [
        '.elgg-body'
      ]
    })
  })

  it('should have enough entries', function () {
    cy.get('.elgg-item').should('have.length.of.at.least', this.counts.board.minEntries)
  })

  it('has pagination', function () {
    cy.get('.elgg-pagination li').should('have.length.of.at.least', this.counts.board.minPages)
  })

  it('should have a working pagination', function () {
    cy.get('.elgg-listing-summary-title:first a span').invoke('text')
      .then(
        firstItemTitle => {
          cy.get('.elgg-pagination:first li:last').click()

          cy.get('.elgg-listing-summary-title:first a span').should('not.contain', firstItemTitle)
        }
      )
  })

})
