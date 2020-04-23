describe('The embed feature', function () {
  beforeEach(function () {
    cy.fixCypressSpec('/cypress/integration/embed_spec.ts')
    cy.login()
    cy.visit('/event_calendar/add')
    cy.get('iframe')
  })
  it('should have a valid UI', function () {
    cy.get('[data-menu-item=embed]').click()
    cy.get('#cboxLoadingOverlay').should('not.be.visible')
    cy.get('#cboxContent').toMatchImageSnapshot({
      name: `embed.${Cypress.env('viewtype')}`,
      blackout: [
        '#cboxContent .elgg-list'
      ]
    })
    cy.get('[data-menu-item=tab-1]').click()
    cy.get('#cboxLoadingOverlay').should('not.be.visible')
    cy.get('#cboxContent iframe')
    cy.get('#cboxContent').toMatchImageSnapshot({
      name: `embed_upload.${Cypress.env('viewtype')}`
    })
  })
  it('should allow to embed files into the editor', function () {
    cy.get('[data-menu-item=embed]').click()
    cy.get('#cboxLoadingOverlay').should('not.be.visible')
    cy.get('[data-menu-item=tab-1]').click()
    cy.get('#cboxLoadingOverlay').should('not.be.visible')
    cy.get('#cboxContent iframe')
    cy.get('[name=upload]').attachFile('testembed.png', 'image/png')
    cy.get('.elgg-form-embed .elgg-button-submit').click()
    cy.get('#cboxLoadingOverlay').should('not.be.visible')
    cy.contains('testembed.png').click()
    cy.get('iframe')
      .then(
        iframe => {
          cy.wrap(iframe.contents()).get('img[alt="testembed.png"]').should('be.visible')
        }
      )
  })
})
