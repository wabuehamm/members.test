describe('The search feature', () => {
  beforeEach(function() {
    cy.login()
    cy.visit(`/search?q=${this.testdata.search.term}&search_type=all`)
  })
  it('should return a minimum set of results', function () {
    cy.wrap(Object.keys(this.counts.search.minResults))
      .each(
        (selector, index, collection) => {
          cy.get(selector).
            then(
              elem => {
                expect(parseInt(elem.text())).to.be.at.least(parseInt(this.counts.search.minResults[selector]))
              }
          )
        }
      )
  })
})
