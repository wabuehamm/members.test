// ***********************************************************
// This example support/index.js is processed and
// loaded automatically before your test files.
//
// This is a great place to put global configuration and
// behavior that modifies Cypress.
//
// You can change the location of this file or turn off
// automatically serving support files with the
// 'supportFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/configuration
// ***********************************************************

// Import commands.js using ES2015 syntax:
import './commands'
import 'cypress-plugin-snapshots/commands'

// Alternatively you can use CommonJS syntax:
//require('./commands')

beforeEach(() => {
    if (Cypress.env('viewtype') === 'mobile') {
        cy.log('Setting mobile view')
        cy.viewport('samsung-s10')
    } else {
        cy.log('Setting desktop view')
        cy.viewport(1400, 768)
    }
})

before(function () {
    cy.log('Loading fixtures')

    cy.fixture('identifiers').as('identifiers')
    cy.fixture('counts').as('counts')
    cy.fixture('testdata').as('testdata')
    cy.fixture('errors').as('errors')

    cy.prepare()
})

Cypress.on('uncaught:exception', function (err, runnable) {
    for (const errorMessage of this.knownErrors) {
        if (err.message.match(new RegExp(errorMessage))) {
            return false
        }
    }
})
