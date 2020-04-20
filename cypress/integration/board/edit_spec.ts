describe('Editing a discusson to the board', () => {
  beforeEach(function() {
    cy.fixCypressSpec('/cypress/integration/board/edit_spec.ts')
    cy.login()
    cy.log('Adding test discussion')
    cy.request({
      method: 'POST',
      url: `/services/api/rest/json/?method=wabue.discussion.add&auth_token=${this.token}&discussion=${encodeURIComponent(JSON.stringify(this.testdata.board.add))}`
    })
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()
    cy.get('[data-menu-item=entity-menu-toggle]').click()
    cy.get('[data-menu-item=edit').click()
    cy.get('iframe')
  })

  it('should have a valid edit form', function () {
    cy.document().toMatchImageSnapshot({
      name: `board_edit.${Cypress.env('viewtype')}`
    })
  })

  it('should work', function () {
    cy.get(`[name=title]`).clear().type(this.testdata.board.edit.title)

    for (const key of ['status', 'access_id']) {
      cy.get(`[name=${key}]`).select(this.testdata.board.add[ key ])
    }

    cy.typeCkEditor(this.testdata.board.edit['description'])
    cy.get('.elgg-form-discussion-save .elgg-button-submit').click()

    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.edit.title).click()

    for (const testString of this.testdata.board.editVerification) {
      cy.contains(testString)
    }
  })

})
