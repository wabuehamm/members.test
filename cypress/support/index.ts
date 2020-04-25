import './commands'
import 'cypress-plugin-snapshots/commands'

beforeEach(() => {
    if (Cypress.env('viewtype') === 'mobile') {
        cy.log('Setting mobile view')
        cy.viewport('samsung-s10')
    } else {
        cy.log('Setting desktop view')
        cy.viewport(1400, 768)
        Cypress.env('viewtype', 'desktop')
    }
    cy.prepare()
})

before(function () {
    cy.log('Loading fixtures')

    cy.fixture('identifiers').as('identifiers')
    cy.fixture('counts').as('counts')
    cy.fixture('testdata').as('testdata')
    cy.fixture('errors').as('errors')
})

Cypress.on('uncaught:exception', function (err, runnable) {
    for (const errorMessage of this.knownErrors) {
        if (err.message.match(new RegExp(errorMessage))) {
            return false
        }
    }
})
