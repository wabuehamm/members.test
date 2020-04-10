describe('Deleting a discusson to the board', () => {
  beforeEach(function() {
    cy.fixCypressSpec('/cypress/integration/board/delete_spec.ts')
    cy.login()
    cy.log('Adding test discussion')
    cy.request({
      method: 'POST',
      form: true,
      body: this.testdata.board.add,
      url: '/action/discussion/save'
    })
  })

  it('should work', function () {
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
    cy.get('[data-menu-item=entity-menu-toggle]').click()
    cy.get('[data-menu-item=delete').click()
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).should('not.exist')
  })

})
