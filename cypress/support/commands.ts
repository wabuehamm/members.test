/// <reference types="cypress" />
declare global {
  namespace Cypress {
    interface Chainable {
      login (username?: string, password?: string): void

      prepare (): void

      fixCypressSpec (filename: string): void

      clearNotifications (token: string): void

      typeCkEditor (content: string, instanceID?: string): Chainable

      attachFile (fileName: string, fileType: string): Chainable

      todo (): void

      logout (): void
    }
  }
}

import * as path from 'path'
import { join } from 'path'
import PluginConfigOptions = Cypress.PluginConfigOptions
import Chainable = Cypress.Chainable
import PrevSubject = Cypress.PrevSubject

/**
 * Login to the member area
 * @param username Username to use (defaults to the first testuser username)
 * @param password Password to use (defaults to the first testuser password)
 */
export function login (username: string, password: string): void {
  if (!username) {
    username = this.testdata.users[ 0 ].username
  }

  if (!password) {
    password = this.testdata.users[ 0 ].password
  }

  cy.request({
    url: '/'
  })
    .then(
      response => {
        const matches = response.body.match(/name="__elgg_token" value="([^"]+)".*name="__elgg_ts" value="([^"]+)"/)
        expect(matches).to.not.be.null
        const token = matches[ 1 ]
        const ts = matches[ 2 ]

        cy.request({
          method: 'POST',
          url: '/action/login',
          form: true,
          body: {
            username: username,
            password: password,
            '__elgg_token': token,
            '__elgg_ts': ts
          }
        })
      }
    )
    .then(
      resp => {
        expect(resp.status).to.eq(200)
        expect(cy.getCookie('Elgg')).to.exist
      }
    )
}

Cypress.Commands.add('login', login)

/**
 * Prepare test environment. Login as admin, recreate test users
 */
export function prepare (): void {
  cy.log('Checking admin credentials')
  if (!Cypress.env('admin_username')) {
    expect(false, 'No CYPRESSS_admin_username environment variable found').to.be.true
  }

  if (!Cypress.env('admin_password')) {
    expect(false, 'No CYPRESSS_admin_password environment variable found').to.be.true
  }

  cy.log('Logging in as admin user')
  cy.login(Cypress.env('admin_username'), Cypress.env('admin_password'))

  for (const testUser of this.testdata.users) {
    cy.log(`(Re-)creating user ${testUser.username}`)
    cy.request({
      url: `/services/api/rest/json/?method=auth.gettoken&username=${Cypress.env('admin_username')}&password=${Cypress.env(
        'admin_password')}`,
      method: 'POST'
    })
      .then(
        resp => {
          expect(resp.body.status).to.eq(0)
          const token = resp.body.result
          this.token = token
          const user = encodeURIComponent(JSON.stringify(testUser))
          cy.request({
            method: 'POST',
            url: `/services/api/rest/json/?method=wabue.users.add&auth_token=${token}&user=${user}`
          })
            .then(
              (resp) => {
                expect(resp.status).to.eq(200)
              }
            )
        }
      )
  }

  cy.clearCookies()
}

Cypress.Commands.add('prepare', prepare)

/**
 * A temporary cypress fix for visual testing in the complete testsuite as long as
 * https://github.com/cypress-io/cypress/issues/3090 is around
 *
 * @param filename path to filename of spec
 */
export function fixCypressSpec (filename: string): void {
  const relative = filename.substr(1) // removes leading "/"
  const projectRoot = Cypress.config<any>('projectRoot')
  const absolute = path.join(projectRoot, relative)
  Cypress.spec = {
    absolute,
    name: path.basename(filename),
    relative
  }
}

Cypress.Commands.add('fixCypressSpec', fixCypressSpec)

/**
 * Workaround to type into CKEditor instance using Cypress. Courtesy of
 * https://medium.com/@nickdenardis/getting-cypress-js-to-interact-with-ckeditor-f46eec01132f
 */
export function typeCkEditor (content: string, instanceID?: string): Chainable {
  cy.get('iframe:visible')
  return cy.window()
    .then(win => {
      let editorInstance: CKEDITOR.editor
      const ckEditor: any = win[ 'CKEDITOR' ]
      if (instanceID) {
        editorInstance = ckEditor.instances[ instanceID ]
      } else {
        editorInstance = ckEditor.instances[ Object.keys(ckEditor.instances)[ 0 ] ]
      }

      editorInstance.setData(content)
      editorInstance.updateElement()
    })
}

Cypress.Commands.add('typeCkEditor', typeCkEditor)

/**
 * Attach a file to an input
 *
 * @param input The input element
 * @param fileName The name of the file to upload in the fixtures
 * @param fileType The type of the file to upload
 */
export function attachFile (input: Element, fileName: string, fileType: string): Chainable {
  return cy.fixture(fileName)
    .then(content => {
      if (fileType.startsWith('text')) {
        return content
      } else {
        return Cypress.Blob.base64StringToBlob(content, fileType)
      }
    })
    .then(blob => {
      const testFile = new File([blob], fileName)
      const dataTransfer = new DataTransfer()

      dataTransfer.items.add(testFile)
      input[ 0 ].files = dataTransfer.files
      return input
    })
}

Cypress.Commands.add(
  'attachFile',
  {
    prevSubject: 'element',
  },
  attachFile
)

export function clearNotifications (token: string): void {
  cy.log('Triggering notifications')
  cy.request({
    url: `/services/api/rest/json/?method=filetransport.notifications.send&auth_token=${token}`,
    method: 'POST'
  })
    .then(
      resp => {
        expect(resp.body.status).to.eq(0)
        cy.log('Flushing notifications')
        cy.request({
          url: `/services/api/rest/json/?method=filetransport.notifications.flush&auth_token=${token}`,
          method: 'POST'
        })
          .then(resp => {
            expect(resp.body.status).to.eq(0)
          })
      }
    )
}

Cypress.Commands.add(
  'clearNotifications',
  clearNotifications
)

/**
 * Quickly stub a test as to be done
 */
export function todo (): void {
  expect(false, 'Test has yet to be written').to.be.true
}

Cypress.Commands.add(
  'todo',
  todo
)

/**
 * Logout of the members area
 */
export function logout (): void {
  if (Cypress.env('viewtype') == 'mobile') {
    cy.get('.elgg-nav-button').should('be.visible').click()
  } else {
    cy.get('[data-menu-item=account] ul').invoke('show').should('be.visible')
  }
  cy.get('[data-menu-item=logout').click()
  cy.clearCookies()
  cy.get('[data-menu-item=account]').should('not.be.visible')
}

Cypress.Commands.add(
  'logout',
  logout
)
