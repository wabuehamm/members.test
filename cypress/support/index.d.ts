/// <reference types="cypress" />

declare namespace Cypress {
  interface Chainable {
    login(username?: string, password?: string): void
    prepare(): void
    fixCypressSpec(filename: string): void
    typeCkEditor(content: string): Chainable
  }
}
