describe('The list of members', function () {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/members/members_spec.ts')
    cy.login()
    cy.visit('/members/alpha')
  })

  it('is reachable', function () {
    cy.contains(this.identifiers.members.title)
    // make screenshot, but blackout member list, pagination and count of members (in the search form footer)
    cy.document().toMatchImageSnapshot({
      name: 'members',
      blackout: [
        '.elgg-list',
        '.elgg-form-footer',
        '.elgg-pagination'
      ]
    })
  })
  it('shows enough members', function () {
    cy.get('.elgg-text-help').then(
      (elem) => {
        const members = elem.text().match(this.identifiers.members.totalMembersRegexp)
        expect(members).to.be.not.null
        if (members) {
          expect(parseInt(members[1])).to.be.at.least(this.counts.members.minMembers)
        }
      }
    )
  })
  it('has enough items', function () {
    cy.get('.elgg-item').should('have.length.of.at.least', this.counts.members.minEntries)
  })
  it('should have pagination', function () {
    cy.get('.elgg-pagination li').should('have.length.of.at.least', this.counts.members.minPages)
  })
  it('does not have the "popular" tab', function () {
    cy.contains(this.identifiers.members.popularTabLabel).should('not.be.visible')
  })
})
