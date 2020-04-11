/// <reference types="cypress" />

declare namespace Cypress {
  interface Chainable {
    login(username?: string, password?: string): void
    prepare(): void
    fixCypressSpec(filename: string): void
    clearNotifications(token: string): void
    typeCkEditor(content: string, instanceID?: string): Chainable
    attachFile(fileName: string, fileType: string): Chainable
  }
}
