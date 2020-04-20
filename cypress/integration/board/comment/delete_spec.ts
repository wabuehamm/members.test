describe('Deleting a comment on the board', () => {
  beforeEach(function() {
    cy.fixCypressSpec('/cypress/integration/board/comment/delete_spec.ts')
    cy.login()
    cy.log('Adding test discussion')
    cy.request({
      method: 'POST',
      url: `/services/api/rest/json/?method=wabue.discussion.add&auth_token=${this.token}&discussion=${encodeURIComponent(JSON.stringify(this.testdata.board.add))}`
    })
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
    cy.typeCkEditor(this.testdata.board.comments.add)
    cy.get('.elgg-form-comment-save .elgg-button-submit').click()
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
  })

  it('should work', function () {
    cy.get('.comments-list .elgg-item:first [data-menu-item=entity-menu-toggle]').click()
    cy.get('.elgg-entity-dropdown-menu:visible [data-menu-item=delete]').click()
  })

})
