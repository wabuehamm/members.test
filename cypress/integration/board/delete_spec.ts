describe('Deleting a discusson to the board', () => {
  beforeEach(function() {
    cy.fixCypressSpec('/cypress/integration/board/delete_spec.ts')
    cy.login()
    cy.log('Adding test discussion')
    cy.request({
      method: 'POST',
      url: `/services/api/rest/json/?method=wabue.discussion.add&auth_token=${this.token}&discussion=${encodeURIComponent(JSON.stringify(this.testdata.board.add))}`
    })
  })

  it('should work', function () {
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
    cy.get('iframe')
    cy.get('[data-menu-item=entity-menu-toggle]').click()
    cy.get('[data-menu-item=delete').click()
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).should('not.exist')
  })

})
