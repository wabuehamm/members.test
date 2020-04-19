describe('The private message feature', function () {
  it('should have a known UI', function () {
    cy.login()
    cy.visit(`/messages/inbox/${this.testdata.users[ 0 ].username}`)
    cy.get('[data-menu-item=add]').click()
    cy.document().toMatchImageSnapshot({
      name: `messages.${Cypress.env('viewtype')}`
    })
  })
  let sendMessage = function (testdata, identifiers) {
    cy.login()
    cy.visit(`/messages/inbox/${testdata.users[ 0 ].username}`)
    cy.get('[data-menu-item=add]').click()
    cy.get('iframe')
    cy.get('[data-name=recipients] input[type=text]').type(`${testdata.messages.send.recipients}`)
    cy.get('.ui-autocomplete').should('be.visible')
    cy.get('.ui-autocomplete li:first').click()
    cy.get('[name=subject]').type(testdata.messages.send.subject)
    cy.typeCkEditor(testdata.messages.send.body)
    cy.get('.elgg-form-messages-send').submit()
    cy.contains(identifiers.messages.messageSent)
    cy.logout()
  }
  it('should allow to send a message', function () {
    sendMessage(this.testdata, this.identifiers)
    cy.login(this.testdata.users[ 1 ].username, this.testdata.users[ 1 ].password)
    cy.visit(`/messages/inbox/${this.testdata.users[ 1 ].username}`)
    cy.contains(this.testdata.messages.send.subject).click()
    cy.contains(this.testdata.messages.send.subject)
    cy.contains(this.testdata.messages.send.body)
  })
  it.only('should allow to reply to a message', function () {
    sendMessage(this.testdata, this.identifiers)
    cy.login(this.testdata.users[ 1 ].username, this.testdata.users[ 1 ].password)
    cy.visit(`/messages/inbox/${this.testdata.users[ 1 ].username}`)
    cy.contains(this.testdata.messages.send.subject).click()
    cy.get('[data-menu-item=reply]').click()
    cy.get('[name=subject]').clear().type(this.testdata.messages.reply.subject)
    cy.typeCkEditor(this.testdata.messages.reply.body)
    cy.get('.elgg-form-messages-reply').submit()
    cy.logout()
    cy.login()
    cy.visit(`/messages/inbox/${this.testdata.users[ 0 ].username}`)
    cy.contains(this.testdata.messages.reply.subject).click()
    cy.contains(this.testdata.messages.reply.subject)
    cy.contains(this.testdata.messages.reply.body)
  })
  it('should allow to delete a message', function () {
    sendMessage(this.testdata, this.identifiers)
    cy.login(this.testdata.users[ 1 ].username, this.testdata.users[ 1 ].password)
    cy.visit(`/messages/inbox/${this.testdata.users[ 1 ].username}`)
    cy.get('[data-menu-item=entity-menu-toggle]:first').click()
    cy.get('[data-menu-item=delete]').click()
    cy.get('.elgg-message').click()
    cy.contains(this.testdata.messages.send.subject).should('not.exist')
  })
})
