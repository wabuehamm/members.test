describe('Adding a discusson to the board', () => {
  beforeEach(function() {
    cy.fixCypressSpec('/cypress/integration/board/add_spec.ts')
    cy.login()
    cy.visit(`/discussion/add/${this.testdata.board.boardId}`)
  })

  it('should have a valid entry form', function () {
    cy.document().toMatchImageSnapshot({
      name: `board_add.${Cypress.env('viewtype')}`
    })
  })

  it('should work', function () {
    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).should('not.exist')

    cy.visit(`/discussion/add/${this.testdata.board.boardId}`)
    cy.get(`[name=title]`).type(this.testdata.board.add.title)

    for (const key of ['status', 'access_id']) {
      cy.get(`[name=${key}]`).select(this.testdata.board.add[ key ])
    }

    cy.typeCkEditor(this.testdata.board.add['description'])
    cy.get('.elgg-form-discussion-save .elgg-button-submit').click()

    cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
    cy.contains(this.testdata.board.add.title).click()

    for (const testString of this.testdata.board.addVerification) {
      cy.contains(testString)
    }
  })

})
