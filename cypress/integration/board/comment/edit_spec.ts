describe('Editing a comment on the board', () => {
  beforeEach(function() {
    cy.fixCypressSpec('/cypress/integration/board/comment/edit_spec.ts')
    cy.login()
    cy.log('Adding test discussion')
    cy.request({
      method: 'POST',
      form: true,
      body: this.testdata.board.add,
      url: '/action/discussion/save'
    })
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
    cy.typeCkEditor(this.testdata.board.comments.add)
    cy.get('.elgg-form-comment-save .elgg-button-submit').click()
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
    cy.get('.comments-list .elgg-item:first [data-menu-item=entity-menu-toggle]').click()
    cy.get('.elgg-entity-dropdown-menu:visible [data-menu-item=edit]').click()
  })

  it('should have a valid form', function () {
    cy.document().toMatchImageSnapshot({
      name: `board_comment_edit.${Cypress.env('viewtype')}`
    })
  })

  it('should work', function () {
    cy.get('.elgg-form-comment-save:visible [name=generic_comment]')
      .then(
        textArea => {
          cy.typeCkEditor(this.testdata.board.comments.edit, textArea.attr('id'))
          cy.get('.elgg-form-comment-save:visible .elgg-button-submit').click()
          cy.get('.elgg-spinner').should('not.be.visible')
        }
      )
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
    cy.contains(this.testdata.board.comments.edit)
  })

})
